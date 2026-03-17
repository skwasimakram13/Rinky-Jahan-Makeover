import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);

  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _secondaryContainer = Color(0xFFF9DCD6);
  static const _surfaceHigh = Color(0xFFEDE7DE);
  static const _surfaceHighest = Color(0xFFE7E2D9);
  static const _surfaceLow = Color(0xFFF9F3EA);
  static const _outlineVariant = Color(0xFFD7C2BE);
  static const _error = Color(0xFFBA1A1A);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Glassmorphic sticky header ──────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _AccountAppBarDelegate(
              primary: _primary,
              onSurface: _onSurface,
              onSurfaceVariant: _onSurfaceVariant,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 80),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Profile header ──────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      // Avatar with Gold Member badge
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _surfaceHighest, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF894E46)
                                      .withOpacity(0.08),
                                  blurRadius: 30,
                                  offset: const Offset(0, 12),
                                )
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAmEilDbyoutgAfmnePi7NIUzYgM-vno-8PskUVK-aIapVxeUd6VPwYrfwI3LeNRBibWf7Ehsvdt_1HzFlTh_4PUa4WkGMdj4L8wY45a105qzr2q4eUMuroTmJOFnIq0cQQK7fHZzkd_suvH70tW9dvWqhdMR3v0uTrXeQLtdQKZEVKqQNaH_MI8e3mHmKUI7I_UxH9kBhdI4MxQbfnvl-vBxqhTcCfu50bzbNbSximwatfDVzjGzdkPxwZd0-wvSIcSw5ZqcYNmYA',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: _primaryContainer,
                                  child: const Icon(Icons.person,
                                      color: Colors.white, size: 56),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    _primaryContainer,
                                    _primary
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        _primary.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Text(
                                'GOLD MEMBER',
                                style: GoogleFonts.manrope(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Jahanara Rinky',
                        style: GoogleFonts.notoSerif(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: _onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'jahanara.rinky@example.com',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          color: _onSurfaceVariant.withOpacity(0.70),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Bento stats (2-col grid) ────────────────────────────
                const Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.auto_awesome_rounded,
                        label: 'REWARD POINTS',
                        value: '12,450',
                        bg: _secondaryContainer,
                        onSurface: Color(0xFF75605B),
                        primary: _primary,
                        useSerif: true,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.event_available_rounded,
                        label: 'NEXT BOOKING',
                        value: 'Oct 24, 2:00 PM',
                        bg: _surfaceHigh,
                        onSurface: _onSurface,
                        primary: _primary,
                        useSerif: true,
                        smallValue: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Personal Journey section ────────────────────────────
                Text(
                  'Personal Journey',
                  style: GoogleFonts.notoSerif(
                      fontSize: 19, color: _onSurface),
                ),
                const SizedBox(height: 12),
                _MenuGroup(
                  bg: _secondaryContainer.withOpacity(0.45),
                  divColor: _outlineVariant.withOpacity(0.15),
                  items: [
                    _MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      label: 'Orders',
                      primary: _primary,
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.calendar_month_outlined,
                      label: 'Bookings',
                      primary: _primary,
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.favorite_border,
                      label: 'Wishlist',
                      primary: _primary,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Preferences section ─────────────────────────────────
                Text(
                  'Preferences',
                  style: GoogleFonts.notoSerif(
                      fontSize: 19, color: _onSurface),
                ),
                const SizedBox(height: 12),
                _MenuGroup(
                  bg: _surfaceLow,
                  divColor: _outlineVariant.withOpacity(0.15),
                  items: [
                    _MenuItem(
                      icon: Icons.person_outline,
                      label: 'Profile Settings',
                      primary: _primary,
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.notifications_none,
                      label: 'Notifications',
                      primary: _primary,
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.logout,
                      label: 'Log Out',
                      primary: _error,
                      isDestructive: true,
                      onTap: () {
                        context.go('/login');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Support banner ──────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: _surfaceHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need any assistance?',
                            style: GoogleFonts.notoSerif(
                                fontSize: 17, color: _onSurface),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Our beauty consultants are available\n24/7 for you.',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: _onSurfaceVariant,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    _primaryContainer,
                                    _primary
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(999),
                              ),
                              child: Text(
                                'CONTACT CONCIERGE',
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Decorative blurred circle
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primary.withOpacity(0.05),
                          ),
                        ),
                      ),
                    ],
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

// ── App bar delegate ──────────────────────────────────────────────────────────

class _AccountAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color primary;
  final Color onSurface;
  final Color onSurfaceVariant;

  _AccountAppBarDelegate({
    required this.primary,
    required this.onSurface,
    required this.onSurfaceVariant,
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
                Icon(Icons.menu, color: onSurfaceVariant, size: 22),
                const Spacer(),
                Text(
                  'Rinky Jahan Makeover',
                  style: GoogleFonts.notoSerif(
                    fontSize: 17,
                    color: onSurface,
                  ),
                ),
                const Spacer(),
                Icon(Icons.shopping_bag_outlined,
                    color: onSurfaceVariant, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AccountAppBarDelegate old) => false;
}

// ── Bento stat card ───────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color bg;
  final Color onSurface;
  final Color primary;
  final bool useSerif;
  final bool smallValue;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.bg,
    required this.onSurface,
    required this.primary,
    this.useSerif = false,
    this.smallValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primary, size: 28),
          const Spacer(),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: onSurface.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: useSerif
                ? GoogleFonts.notoSerif(
                    fontSize: smallValue ? 16 : 22,
                    color: onSurface,
                    height: 1.2,
                  )
                : GoogleFonts.manrope(
                    fontSize: smallValue ? 15 : 20,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Menu group (card with dividers) ──────────────────────────────────────────

class _MenuGroup extends StatelessWidget {
  final Color bg;
  final Color divColor;
  final List<_MenuItem> items;

  const _MenuGroup(
      {required this.bg, required this.divColor, required this.items});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        color: bg,
        child: Column(
          children: items.map((item) {
            final isLast = item == items.last;
            return Column(
              children: [
                item,
                if (!isLast) Divider(height: 1, color: divColor),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primary;
  final bool isDestructive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.primary,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? primary : const Color(0xFF1D1B16);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: primary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            if (!isDestructive)
              const Icon(Icons.chevron_right,
                  color: Color(0xFFD7C2BE), size: 20),
          ],
        ),
      ),
    );
  }
}
