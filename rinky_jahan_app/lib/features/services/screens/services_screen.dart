import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/services_provider.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  final _searchCtrl = TextEditingController();

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _surfaceContainer = Color(0xFFF3EDE4);
  static const _surfaceLow = Color(0xFFF9F3EA);
  static const _secondaryContainer = Color(0xFFF9DCD6);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _secondary = Color(0xFF6E5A55);
  static const _onSecondaryContainer = Color(0xFF75605B);

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(servicesProvider);
    final cats = ref.watch(servicesCategoriesProvider);
    final items = state.filtered;

    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Sticky glassmorphic header ──────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _ServicesAppBarDelegate(
              primary: _primary,
              onSurface: _onSurface,
              onCartTap: () => context.push('/shop'),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Search bar ────────────────────────────────────────────
                _ServicesSearchBar(
                  controller: _searchCtrl,
                  surfaceLow: _surfaceLow,
                  onSurfaceVariant: _onSurfaceVariant,
                  primary: _primary,
                  onChanged:
                      ref.read(servicesProvider.notifier).search,
                ),
                const SizedBox(height: 16),

                // ── Category filter chips ─────────────────────────────────
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
                            .read(servicesProvider.notifier)
                            .selectCategory(cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _primary
                                : _surfaceContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : _onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // ── Editorial intro ───────────────────────────────────────
                Column(
                  children: [
                    Text(
                      'CURATED EXPERIENCE',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        letterSpacing: 2.5,
                        color: _primary.withOpacity(0.60),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'The Art of Radiance',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSerif(
                        fontSize: 28,
                        color: _onSurface,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore our tailored menu of luxury aesthetic\n'
                      'treatments designed for your unique essence.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: _secondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Service cards ─────────────────────────────────────────
                if (items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'No services found',
                        style: GoogleFonts.manrope(
                            fontSize: 14, color: _onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  ...items.map(
                    (svc) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ServiceCard(
                        service: svc,
                        primary: _primary,
                        primaryContainer: _primaryContainer,
                        secondaryContainer: _secondaryContainer,
                        onSecondaryContainer: _onSecondaryContainer,
                        secondary: _secondary,
                        onBookNow: () {
                          // Navigate to booking when that screen is built
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Booking "${svc.name}" — coming soon!'),
                              backgroundColor: _primary,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                // ── Botanical SVG accent ──────────────────────────────────
                const SizedBox(height: 40),
                Center(
                  child: Opacity(
                    opacity: 0.20,
                    child: CustomPaint(
                      size: const Size(120, 120),
                      painter: _FloralPainter(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── App bar delegate ──────────────────────────────────────────────────────────

class _ServicesAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color primary;
  final Color onSurface;
  final VoidCallback onCartTap;

  _ServicesAppBarDelegate({
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
    return SizedBox.expand(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: const Color(0xFFFFF9EF).withOpacity(0.85),
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.menu, color: primary, size: 22),
                const SizedBox(width: 14),
                Text(
                  'Rinky Jahan Makeover',
                  style: GoogleFonts.notoSerif(
                    fontSize: 17,
                    color: onSurface,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onCartTap,
                  child: Icon(Icons.shopping_bag_outlined,
                      color: primary, size: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ServicesAppBarDelegate old) => false;
}

// ── Search bar ────────────────────────────────────────────────────────────────

class _ServicesSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Color surfaceLow;
  final Color onSurfaceVariant;
  final Color primary;
  final ValueChanged<String> onChanged;

  const _ServicesSearchBar({
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
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary.withOpacity(0.30), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}

// ── Service card ──────────────────────────────────────────────────────────────

class _ServiceCard extends StatelessWidget {
  final ServiceItem service;
  final Color primary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color secondary;
  final VoidCallback onBookNow;

  const _ServiceCard({
    required this.service,
    required this.primary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.secondary,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: secondaryContainer,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF894E46).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: primaryContainer.withOpacity(0.30),
                  child: Icon(Icons.spa, color: primary, size: 36),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: GoogleFonts.notoSerif(
                    fontSize: 17,
                    color: onSecondaryContainer,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service.description,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: onSecondaryContainer.withOpacity(0.65),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service.price,
                      style: GoogleFonts.notoSerif(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onBookNow,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryContainer, primary],
                          ),
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withOpacity(0.20),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Text(
                          'Book Now',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Botanical SVG painter ─────────────────────────────────────────────────────

class _FloralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF857370)
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;
    // Simple leaf/petal shape
    path.moveTo(w * 0.5, 0);
    path.cubicTo(w * 0.3, h * 0.4, w * -0.1, h * 0.4, w * 0.1, h * 0.4);
    path.cubicTo(w * -0.1, h * 0.4, w * 0.3, h, w * 0.5, h);
    path.cubicTo(w * 0.7, h, w * 1.1, h * 0.4, w * 0.9, h * 0.4);
    path.cubicTo(w * 1.1, h * 0.4, w * 0.7, h * 0.4, w * 0.5, 0);
    paint.color = const Color(0xFF857370).withOpacity(0.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
