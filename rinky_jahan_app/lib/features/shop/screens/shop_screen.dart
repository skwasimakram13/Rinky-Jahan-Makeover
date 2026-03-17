import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/shop_provider.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  final _searchCtrl = TextEditingController();

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _secondary = Color(0xFF6E5A55);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _surfaceContainer = Color(0xFFF3EDE4);
  static const _surfaceLow = Color(0xFFF9F3EA);
  static const _secondaryContainer = Color(0xFFF9DCD6);

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shopProvider);
    final cats = ref.watch(shopCategoriesProvider);
    final products = state.filtered;

    // Split products into two columns for staggered layout
    final leftCol = <ShopProduct>[];
    final rightCol = <ShopProduct>[];
    for (var i = 0; i < products.length; i++) {
      if (i.isEven) {
        leftCol.add(products[i]);
      } else {
        rightCol.add(products[i]);
      }
    }

    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Glassmorphic sticky header ──────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _ShopAppBarDelegate(
              cartCount: state.cartCount,
              primary: _primary,
              onSurface: _onSurface,
              onCartTap: () => context.push('/cart'),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 80),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── "The Boutique" title ────────────────────────────────
                Text(
                  'The Boutique',
                  style: GoogleFonts.notoSerif(
                    fontSize: 36,
                    letterSpacing: -0.5,
                    color: _onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Search bar ────────────────────────────────────────────
                _ShopSearchBar(
                  controller: _searchCtrl,
                  surfaceLow: _surfaceLow,
                  onSurfaceVariant: _onSurfaceVariant,
                  primary: _primary,
                  onChanged:
                      ref.read(shopProvider.notifier).search,
                ),
                const SizedBox(height: 14),

                // ── Filter chips ──────────────────────────────────────────
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cats.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, i) {
                      final cat = cats[i];
                      final isSelected = state.selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => ref
                            .read(shopProvider.notifier)
                            .selectCategory(cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [_primaryContainer, _primary])
                                : null,
                            color: isSelected ? null : _surfaceContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : _secondary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // ── Staggered 2-column product grid ───────────────────────
                if (products.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        'No products found',
                        style: GoogleFonts.manrope(
                            fontSize: 14, color: _onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column (starts at normal position)
                      Expanded(
                        child: Column(
                          children: leftCol
                              .map((p) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20),
                                    child: _ProductCard(
                                      product: p,
                                      primary: _primary,
                                      primaryContainer: _primaryContainer,
                                      secondaryContainer:
                                          _secondaryContainer,
                                      secondary: _secondary,
                                      onSurface: _onSurface,
                                      onAdd: () => ref
                                          .read(shopProvider.notifier)
                                          .addToCart(p.id),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Right column (offset down for staggered effect)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: rightCol
                                .map((p) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: _ProductCard(
                                        product: p,
                                        primary: _primary,
                                        primaryContainer: _primaryContainer,
                                        secondaryContainer:
                                            _secondaryContainer,
                                        secondary: _secondary,
                                        onSurface: _onSurface,
                                        onAdd: () => ref
                                            .read(shopProvider.notifier)
                                            .addToCart(p.id),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── App bar delegate ──────────────────────────────────────────────────────────

class _ShopAppBarDelegate extends SliverPersistentHeaderDelegate {
  final int cartCount;
  final Color primary;
  final Color onSurface;
  final VoidCallback onCartTap;

  _ShopAppBarDelegate({
    required this.cartCount,
    required this.primary,
    required this.onSurface,
    required this.onCartTap,
  });

  @override
  double get minExtent => 62;
  @override
  double get maxExtent => 62;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: const Color(0xFFFFF9EF).withOpacity(0.85),
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                Icon(Icons.menu, color: onSurface, size: 22),
                const SizedBox(width: 14),
                Text(
                  'Rinky Jahan Makeover',
                  style: GoogleFonts.notoSerif(
                    fontSize: 17,
                    color: onSurface,
                  ),
                ),
                const Spacer(),
                // Cart icon with badge
                GestureDetector(
                  onTap: onCartTap,
                  child: Stack(
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          color: onSurface, size: 22),
                      if (cartCount > 0)
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF894E46),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ShopAppBarDelegate old) =>
      old.cartCount != cartCount;
}

// ── Search bar ────────────────────────────────────────────────────────────────

class _ShopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Color surfaceLow;
  final Color onSurfaceVariant;
  final Color primary;
  final ValueChanged<String> onChanged;

  const _ShopSearchBar({
    required this.controller,
    required this.surfaceLow,
    required this.onSurfaceVariant,
    required this.primary,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.manrope(fontSize: 14, color: onSurfaceVariant),
      decoration: InputDecoration(
        hintText: 'Search services or products',
        hintStyle: GoogleFonts.manrope(
            fontSize: 14, color: const Color(0xFFD7C2BE)),
        prefixIcon: Icon(Icons.search, color: onSurfaceVariant),
        filled: true,
        fillColor: surfaceLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary.withOpacity(0.25), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}

// ── Product card ──────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final ShopProduct product;
  final Color primary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color secondary;
  final Color onSurface;
  final VoidCallback onAdd;

  const _ProductCard({
    required this.product,
    required this.primary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.secondary,
    required this.onSurface,
    required this.onAdd,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with add-to-cart button overlay
        AspectRatio(
          aspectRatio: 4 / 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background
                Container(color: widget.secondaryContainer),
                // Product image
                Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: widget.secondaryContainer,
                    child: Icon(Icons.spa,
                        color: widget.primaryContainer, size: 56),
                  ),
                ),
                // Add-to-cart circle
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _added = true);
                      widget.onAdd();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [widget.primaryContainer, widget.primary],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.primary.withOpacity(0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _added ? Icons.check : Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Rating row
        Row(
          children: [
            Icon(Icons.star_rounded, color: widget.primary, size: 13),
            const SizedBox(width: 4),
            Text(
              '${widget.product.rating} (${widget.product.reviews})',
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: widget.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          widget.product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.notoSerif(
            fontSize: 16,
            height: 1.25,
            color: widget.onSurface,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.product.price,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: widget.primary,
          ),
        ),
      ],
    );
  }
}
