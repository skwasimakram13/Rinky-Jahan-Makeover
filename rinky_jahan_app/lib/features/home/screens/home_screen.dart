import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchCtrl = TextEditingController();

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _secondaryContainer = Color(0xFFF9DCD6);
  static const _surfaceLow = Color(0xFFF9F3EA);
  static const _surfaceHigh = Color(0xFFEDE7DE);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _secondary = Color(0xFF6E5A55);
  static const _outlineVariant = Color(0xFFD7C2BE);

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // Icon lookup for service categories
  IconData _categoryIcon(String name) {
    switch (name) {
      case 'spa':
        return Icons.spa_outlined;
      case 'face_retouching_natural':
        return Icons.face_retouching_natural;
      case 'content_cut':
        return Icons.content_cut;
      case 'brush':
        return Icons.brush_outlined;
      case 'self_improvement':
        return Icons.self_improvement;
      default:
        return Icons.spa_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          // ── Glassmorphic sticky top app bar ────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _GlassAppBarDelegate(
              userName: home.userName,
              cartCount: home.cartCount,
              primary: _primary,
              primaryContainer: _primaryContainer,
              onSurface: _onSurface,
              secondary: _secondary,
              surfaceHigh: _surfaceHigh,
              outlineVariant: _outlineVariant,
              onCartTap: () => context.push('/shop'),
              topPadding: MediaQuery.of(context).padding.top,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Hero carousel ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: _HeroBanner(
                    primary: _primary,
                    primaryContainer: _primaryContainer,
                    onTap: () => context.go('/services'),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Loyalty points strip ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _LoyaltyStrip(
                    points: home.loyaltyPoints,
                    primary: _primary,
                    primaryContainer: _primaryContainer,
                    secondaryContainer: _secondaryContainer,
                    onSurface: _onSurface,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Search bar ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _SearchBar(
                    controller: _searchCtrl,
                    surfaceLow: _surfaceLow,
                    onSurfaceVariant: _onSurfaceVariant,
                    primary: _primary,
                    onChanged: ref.read(homeProvider.notifier).search,
                  ),
                ),
                const SizedBox(height: 28),

                // ── Service categories ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Our Services',
                          style: GoogleFonts.notoSerif(
                              fontSize: 26, color: _onSurface)),
                      GestureDetector(
                        onTap: () => context.go('/services'),
                        child: Text(
                          'View Catalogue',
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: _primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: home.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                    itemBuilder: (_, i) {
                      final cat = home.categories[i];
                      return _CategoryChip(
                        label: cat.label,
                        icon: _categoryIcon(cat.icon),
                        primary: _primary,
                        surfaceHigh: _surfaceHigh,
                        onSurfaceVariant: _onSurfaceVariant,
                        onTap: () => context.go('/services'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // ── Featured products ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Featured Products',
                          style: GoogleFonts.notoSerif(
                              fontSize: 26, color: _onSurface)),
                      const Row(
                        children: [
                          _NavCircleBtn(
                              icon: Icons.arrow_back_ios_new_rounded,
                              outlineVariant: _outlineVariant),
                          SizedBox(width: 8),
                          _NavCircleBtn(
                              icon: Icons.arrow_forward_ios_rounded,
                              outlineVariant: _outlineVariant),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: home.products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (_, i) {
                      final p = home.products[i];
                      return _ProductCard(
                        product: p,
                        primary: _primary,
                        primaryContainer: _primaryContainer,
                        secondaryContainer: _secondaryContainer,
                        secondary: _secondary,
                        onTap: () => context.push('/shop'),
                        onAddToCart:
                            ref.read(homeProvider.notifier).addToCart,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // ── Latest tutorials ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latest Tutorials',
                          style: GoogleFonts.notoSerif(
                              fontSize: 26, color: _onSurface)),
                      const SizedBox(height: 4),
                      Text(
                        'Learn professional beauty tips from Rinky herself.',
                        style: GoogleFonts.manrope(
                            fontSize: 13, color: _secondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...home.tutorials.map(
                  (t) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: _TutorialCard(
                      tutorial: t,
                      primary: _primary,
                      primaryContainer: _primaryContainer,
                      onSurface: _onSurface,
                      secondary: _secondary,
                      onTap: () => context.go('/learn'),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Persistent header delegate ────────────────────────────────────────────────

class _GlassAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String userName;
  final int cartCount;
  final Color primary;
  final Color primaryContainer;
  final Color onSurface;
  final Color secondary;
  final Color surfaceHigh;
  final Color outlineVariant;
  final VoidCallback onCartTap;
  final double topPadding;

  _GlassAppBarDelegate({
    required this.userName,
    required this.cartCount,
    required this.primary,
    required this.primaryContainer,
    required this.onSurface,
    required this.secondary,
    required this.surfaceHigh,
    required this.outlineVariant,
    required this.onCartTap,
    required this.topPadding,
  });

  static const double _kToolbarHeight = 68;

  @override
  double get minExtent => _kToolbarHeight + topPadding;
  @override
  double get maxExtent => _kToolbarHeight + topPadding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.white.withOpacity(0.82),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 12 + topPadding,
              bottom: 12,
            ),
            child: Row(
              children: [
                Icon(Icons.menu, color: onSurface),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'WELCOME BACK',
                      style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: secondary),
                    ),
                    Text(
                      'Hello, $userName',
                      style: GoogleFonts.notoSerif(
                          fontSize: 17, color: onSurface),
                    ),
                  ],
                ),
                const Spacer(),
                // Cart with badge
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_bag_outlined,
                          color: onSurface),
                      onPressed: onCartTap,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [primaryContainer, primary],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Avatar
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: surfaceHigh, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBVH399hyUCA9W9HZd01dPg2zmMY2-9GBhBA5W5PGH6ektj1L6Y-TmtIeUKuu3qsW3zLv3b_zPySJu75yl0-onrH4xZT03GXEgajU9yb9vHKLlgQMcp-TcGxl-nacD04QTcOU1xkE8fSDmKDbJLtoy-P6CdlCtuHbVQEaNmDeXyduVYExLlXn378aXwvnb1GZwPdlamxVM9aGL8jH3KZZ1JSYd_sHl9QE5ZBZkOBy1Y3oE7LCYesROdgn4sJi4z9U_4edBwDHe7UZ0',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        backgroundColor: primaryContainer,
                        child: Text(
                          'P',
                          style: GoogleFonts.notoSerif(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
  bool shouldRebuild(covariant _GlassAppBarDelegate old) => true;
}

// ── Hero banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final Color primary;
  final Color primaryContainer;
  final VoidCallback onTap;

  const _HeroBanner(
      {required this.primary,
      required this.primaryContainer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 360,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAcpWim8uHrlK4vfA1ouGPMrPdlIK4pDPzctfatAN_Ker3qxKhbRRXlHecb8QctsXy0RsNlX0JUdTv-jxV6Tf1b2IAjJxZHmUDBAXAwEUkka7QCYp0wXKg_FRiuzLE_xsBgVGz5e4lD3AyNSBrAL6SadF0VbYFi1MSNQX6ojYuZk2fPb8P7Qgaw5QDHPkTN7lE1H0Eux0K9A8xlG1NEovEOk58Qw108bBlpz4CTeB6YrWE9e-XABjUk_4jFOUYrH6h6zfU8K28YVag',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: primaryContainer.withOpacity(0.30),
                child: const Center(child: Icon(Icons.spa, size: 80)),
              ),
            ),
            // Bottom gradient scrim
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x99000000)],
                  stops: [0.35, 1.0],
                ),
              ),
            ),
            // Text & button
            Positioned(
              bottom: 28,
              left: 28,
              right: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summer Collection 2024',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Elevate Your\nNatural Radiance',
                    style: GoogleFonts.notoSerif(
                      fontSize: 32,
                      height: 1.15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryContainer, primary],
                        ),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.30),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Text(
                        'Explore Services',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Carousel dots
            Positioned(
              bottom: 20,
              right: 24,
              child: Row(
                children: [
                  Container(width: 24, height: 4,
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  Container(width: 6, height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  Container(width: 6, height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Loyalty strip ─────────────────────────────────────────────────────────────

class _LoyaltyStrip extends StatelessWidget {
  final int points;
  final Color primary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color onSurface;
  const _LoyaltyStrip({
    required this.points,
    required this.primary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [primaryContainer, primary]),
            ),
            child: const Icon(Icons.stars_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.manrope(
                    fontSize: 13, color: const Color(0xFF524341)),
                children: [
                  const TextSpan(text: 'Your Glow Points: '),
                  TextSpan(
                    text:
                        '${points.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} pts',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Text(
                'Redeem Now',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: primary,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: primary, size: 14),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Search bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Color surfaceLow;
  final Color onSurfaceVariant;
  final Color primary;
  final ValueChanged<String> onChanged;
  const _SearchBar({
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
        hintStyle:
            GoogleFonts.manrope(fontSize: 14, color: onSurfaceVariant),
        prefixIcon: Icon(Icons.search, color: onSurfaceVariant),
        filled: true,
        fillColor: surfaceLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary.withOpacity(0.30), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}

// ── Category chip ─────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color primary;
  final Color surfaceHigh;
  final Color onSurfaceVariant;
  final VoidCallback onTap;
  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.primary,
    required this.surfaceHigh,
    required this.onSurfaceVariant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: surfaceHigh,
            ),
            child: Icon(icon, color: primary, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Product card ──────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final ProductItem product;
  final Color primary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color secondary;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _ProductCard({
    required this.product,
    required this.primary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.secondary,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF894E46).withOpacity(0.06),
              blurRadius: 30,
              offset: const Offset(0, 12),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: Colors.white),
                    Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white,
                        child: Icon(Icons.spa,
                            color: widget.primaryContainer, size: 56),
                      ),
                    ),
                    // Favourite
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => setState(() => _fav = !_fav),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.85),
                          ),
                          child: Icon(
                            _fav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.primary,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.product.name,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4F201A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.product.subtitle,
              style: GoogleFonts.manrope(
                  fontSize: 11, color: widget.secondary),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.price,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: widget.primary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onAddToCart,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [widget.primaryContainer, widget.primary],
                      ),
                    ),
                    child: const Icon(Icons.add_shopping_cart,
                        color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tutorial card ─────────────────────────────────────────────────────────────

class _TutorialCard extends StatelessWidget {
  final TutorialItem tutorial;
  final Color primary;
  final Color primaryContainer;
  final Color onSurface;
  final Color secondary;
  final VoidCallback onTap;

  const _TutorialCard({
    required this.tutorial,
    required this.primary,
    required this.primaryContainer,
    required this.onSurface,
    required this.secondary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    tutorial.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: const Color(0xFFEDE7DE)),
                  ),
                  // Play overlay
                  Container(color: Colors.black.withOpacity(0.20)),
                  Center(
                    child: ClipOval(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: Colors.white.withOpacity(0.82),
                          child: Icon(Icons.play_arrow_rounded,
                              color: primary, size: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorial.title,
                      style: GoogleFonts.notoSerif(
                          fontSize: 18, color: onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${tutorial.duration} • ${tutorial.views}',
                      style: GoogleFonts.manrope(
                          fontSize: 12, color: secondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border, color: Color(0xFF857370)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Nav circle button ─────────────────────────────────────────────────────────

class _NavCircleBtn extends StatelessWidget {
  final IconData icon;
  final Color outlineVariant;
  const _NavCircleBtn({required this.icon, required this.outlineVariant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: outlineVariant, width: 1),
        color: Colors.transparent,
      ),
      child: Icon(icon, size: 14, color: const Color(0xFF1D1B16)),
    );
  }
}
