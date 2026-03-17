import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  // Brand colours (mirror AppTheme)
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _surfaceHigh = Color(0xFFEDE7DE);
  static const _onSurfaceVariant = Color(0xFF524341);


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext(int current, int total) {
    if (current < total - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOut,
      );
      ref.read(onboardingPageProvider.notifier).nextSlide();
    } else {
      _finish();
    }
  }

  void _goPrev(int current) {
    if (current > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOut,
      );
      ref.read(onboardingPageProvider.notifier).prevSlide();
    }
  }

  Future<void> _finish() async {
    await ref.read(onboardingPageProvider.notifier).completeOnboarding();
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final slides = ref.watch(onboardingSlidesProvider);
    final currentIndex = ref.watch(onboardingPageProvider);
    final isLast = currentIndex == slides.length - 1;

    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          // Subtle radial mesh backgrounds (Slide 3 motif applied globally)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomLeft,
                    radius: 1.2,
                    colors: [
                      const Color(0xFFF9DCD6).withOpacity(0.3),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.5],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.0,
                    colors: [
                      const Color(0xFFFFDAD5).withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.4],
                  ),
                ),
              ),
            ),
          ),

          // Page view
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: slides.length,
            onPageChanged: (i) =>
                ref.read(onboardingPageProvider.notifier).goToSlide(i),
            itemBuilder: (context, index) {
              return _SlidePage(
                slide: slides[index],
                index: index,
                primary: _primary,
                primaryContainer: _primaryContainer,
                surfaceHigh: _surfaceHigh,
              );
            },
          ),

          // ── Header: logo / skip ─────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand logo text (Slide 3 header style)
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: _primary, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'Rinky Jahan',
                          style: GoogleFonts.notoSerif(
                            fontSize: 17,
                            letterSpacing: -0.3,
                            color: const Color(0xFF1D1B16),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: _finish,
                      child: Text(
                        'SKIP',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.8,
                          color: _onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Footer: dots + nav buttons ──────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Pagination dots
                    Row(
                      children: List.generate(slides.length, (i) {
                        final active = i == currentIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 8),
                          width: active ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active ? _primary : _surfaceHigh,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        );
                      }),
                    ),

                    // Nav buttons
                    Row(
                      children: [
                        if (currentIndex > 0) ...[
                          _CircleButton(
                            onTap: () => _goPrev(currentIndex),
                            child: const Icon(Icons.arrow_back,
                                color: Color(0xFF524341), size: 20),
                          ),
                          const SizedBox(width: 12),
                        ],
                        _GradientPillButton(
                          label: isLast ? 'GET STARTED' : 'Next',
                          primary: _primary,
                          primaryContainer: _primaryContainer,
                          trailingIcon: isLast
                              ? Icons.arrow_forward
                              : Icons.arrow_forward_ios,
                          onTap: () => _goNext(currentIndex, slides.length),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Individual slide page ─────────────────────────────────────────────────────

class _SlidePage extends StatelessWidget {
  final OnboardingSlide slide;
  final int index;
  final Color primary;
  final Color primaryContainer;
  final Color surfaceHigh;

  const _SlidePage({
    required this.slide,
    required this.index,
    required this.primary,
    required this.primaryContainer,
    required this.surfaceHigh,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 72,
          bottom: 120,
          left: 24,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            const SizedBox(height: 32),
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final w = MediaQuery.of(context).size.width - 48;

    if (index == 0) {
      // Slide 1: full-width photo with a glassmorphic accent chip
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: w,
              height: w * 0.72,
              child: Image.network(
                slide.imageUrl,
                fit: BoxFit.cover,
                color: primaryContainer.withOpacity(0.15),
                colorBlendMode: BlendMode.multiply,
                errorBuilder: (_, __, ___) => Container(
                    color: surfaceHigh,
                    child: const Center(child: Icon(Icons.spa, size: 48))),
              ),
            ),
          ),
          // Botanical accent
          Positioned(
            top: -12,
            right: -12,
            child: Opacity(
              opacity: 0.10,
              child: Icon(Icons.spa, color: primary, size: 160),
            ),
          ),
          // Glassmorphic chip
          Positioned(
            bottom: 16,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFFFFF9EF).withOpacity(0.70),
                  child: Icon(Icons.auto_awesome, color: primary),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (index == 1) {
      // Slide 2: asymmetric bento grid
      return SizedBox(
        height: w * 0.80,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main large image (col-span-8)
                Expanded(
                  flex: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: w * 0.80,
                      child: Image.network(
                        slide.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: surfaceHigh),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Small column (col-span-4)
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        // Serum thumb
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              slide.secondaryImageUrl ?? slide.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Container(color: const Color(0xFFF9DCD6)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Spa icon placeholder
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: surfaceHigh,
                              child: Center(
                                child: Icon(Icons.spa,
                                    color: primary.withOpacity(0.4), size: 36),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Floating glassmorphic product card
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9EF).withOpacity(0.70),
                      border: Border.all(color: Colors.white.withOpacity(0.20)),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 40,
                            offset: const Offset(0, 20))
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [primary, primaryContainer],
                            ),
                          ),
                          child: const Icon(Icons.shopping_bag,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NEW ARRIVAL',
                                style: GoogleFonts.manrope(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2,
                                    color: primary)),
                            Text('Rose Gold Elixir',
                                style: GoogleFonts.notoSerif(
                                    fontSize: 16,
                                    color: const Color(0xFF1D1B16))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Slide 3: asymmetric video grid
    return SizedBox(
      height: w * 0.75,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main featured video (col-span-4)
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    slide.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: surfaceHigh),
                  ),
                  // Gradient scrim
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x99000000)],
                      ),
                    ),
                  ),
                  // Play button
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: const Color(0xFFFFF9EF).withOpacity(0.70),
                          child: Icon(Icons.play_arrow,
                              color: primary, size: 32),
                        ),
                      ),
                    ),
                  ),
                  // Title
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('The Flawless Base Masterclass',
                            style: GoogleFonts.notoSerif(
                                color: Colors.white, fontSize: 14)),
                        Text('12:45 • Advanced Technique',
                            style: GoogleFonts.manrope(
                                color: Colors.white70, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Two secondary thumbnails (col-span-2)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDjfCCnVHRPL0RBlzeQOXyr9jq-5mVtNfeSWyNprIbSUx2HUyE3ZORyOIqKqviAMw2RiQIWBrp25Kgsya7uPNqakcvdaDc9AKSg8exw_k8o-RBkDcQ-1FFYNPb5pCUlP2yc7cSRJWQiI3VInQlpWzOgtauFj3dRg55a2pAOEVwq8xyoD-ZE-hW2XH1fwc8qD8EhbYiVe4P39wpq3U0HW7ht4PE6UUvcfr7HyApTiZxM1OZ8yC2MUl9HhFqir9tOxBD_AgAmF59bFfs',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: surfaceHigh),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDmfX-lldPocUHODH2vjKfFzh_05HEr0OfzsyhuR6asGUs69nNgdmfNq3wLzTTFCLIWCC2YwMf0fR1TwJV7RzQlPGzb2oFqGa7U7kECwnONaJMvn7XbVCOrOHT9nhzS7T70bXpqmipiLh2FcpDoeYF1JxYDd53f_xjYgp99md8APhSTfoSp7nzLMTYMzzBgIxUMQkzOMyhIfGuLFiiHjD0IxLObQ7zkXXuBfVjgtimBHIJaawgeiEwAMr4Yn52M2vYVWTjMHvz-cuY',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (_, __, ___) =>
                              Container(color: surfaceHigh),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              color: const Color(0xFFFFF9EF)
                                  .withOpacity(0.70),
                              child: Text('NEW',
                                  style: GoogleFonts.manrope(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: primary)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    const charcoal = Color(0xFF1D1B16);
    const muted = Color(0xFF524341);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slide.kicker,
          style: GoogleFonts.manrope(
            fontSize: 11,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          slide.headline,
          style: GoogleFonts.notoSerif(
            fontSize: 40,
            height: 1.1,
            letterSpacing: -0.5,
            color: charcoal,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          slide.body,
          style: GoogleFonts.manrope(
            fontSize: 15,
            height: 1.6,
            color: muted,
          ),
        ),
      ],
    );
  }
}

// ── Shared button widgets ─────────────────────────────────────────────────────

class _GradientPillButton extends StatelessWidget {
  final String label;
  final Color primary;
  final Color primaryContainer;
  final IconData trailingIcon;
  final VoidCallback onTap;

  const _GradientPillButton({
    required this.label,
    required this.primary,
    required this.primaryContainer,
    required this.trailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primary, primaryContainer],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: Colors.white),
            ),
            const SizedBox(width: 8),
            Icon(trailingIcon, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _CircleButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: const Color(0xFF857370).withOpacity(0.3), width: 1),
          color: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}
