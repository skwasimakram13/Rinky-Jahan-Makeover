import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the splash provider — navigate when ready
    ref.listen<AsyncValue<String>>(splashProvider, (_, next) {
      next.whenData((destination) {
        if (mounted) context.go(destination);
      });
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Layer 0: Rose-gold gradient base ────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Color(0xF2894E46), // #894e46 at ~95% opacity
                  Color(0xF2C9847A), // #c9847a at ~95% opacity
                ],
              ),
            ),
          ),

          // ── Layer 1: Botanical background image at 30% opacity ──────────
          Opacity(
            opacity: 0.30,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDZgvXMLHYtKxooaezCjlPP9LcrWTmrO0RMADWoaW5kKlS6j1E-9NjAj8h1Pc8q7lJFieU4QLdxBDhKW1PWv7SqD9Si75jm1WABi9YRUpiO5ckmsGh_P_y20J0UZ9E5Ipbf6sljhXWQNT83hbK2KMF0C1tsDGLeyb_Fdk_ct3qIU4IKd6mHRFOuw53HNjD21qZc9f9-uyWm8075Qy5_pr8umAdgrRLUrfg6zeQ1NsbtGZf9hnp7LjooRe0H5OHRqJylogCpgKOTito',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),

          // ── Layer 2: Top-right floral decor ────────────────────────────
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.10,
            right: -MediaQuery.of(context).size.width * 0.05,
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.50,
            child: Opacity(
              opacity: 0.20,
              child: Transform.rotate(
                angle: 12 * (3.14159 / 180),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDPE3Ycq9zAzHS_OyOVDrGE1nE36KSC7hJn-UuJ4gpV2FUymf7SsA8oL4QHEe1-26I-xV8ZbQ4-MR_RLQG1hoS8C1yqyVjNdifU4swN8tDYzrSYY2vEKnZIQq0MiuFOBqhPMVScnTxzt-C-WfXuqb6JeSB_bAqrCQkwa37oFWuGsOgSMV7W0y7o82E7IXf6Af6Wi5X8jdHSfTutfU5hs0XFnRJw_3e59viEeoybmalvaH_GPvZY5epYLHvnznRRWWdYuLbPO1YGQ2g',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // ── Layer 3: Bottom-left floral decor ──────────────────────────
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.05,
            left: -MediaQuery.of(context).size.width * 0.10,
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.40,
            child: Opacity(
              opacity: 0.15,
              child: Transform.rotate(
                angle: -45 * (3.14159 / 180),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuADfwiLIlMGCTh0f1MzHCuftTZ6dPQEuxMQUIlqG-Q8R_HEz5d-hmP90QkiQmjqpBpMCkqgvsNGMI_ISukLAmz939mIWrLV0-DAmTvwHhWiV0TomxGYgY5dIS4O2E-TvD7sSBI3FsYvVteJzLFP-tA9Xm0XpbqoOnOJoa13LPAyjwsTwW3oHXavqwjjPPW9C9XLbzl1qosTn-V6J3mHUmmFKkAKlxqOMf0G8MkyOPOPh5sx_WR8C9-9ICGsop17ViMxf06e4tg0DgI',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // ── Layer 4: Central brand identity (fade in) ───────────────────
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Label kicker
                  Text(
                    'THE LUXURY SANCTUARY',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      letterSpacing: 4.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Brand headline — Noto Serif
                  Text(
                    'Rinky Jahan\nMakeover',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                      fontSize: 48,
                      height: 1.05,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Thin horizontal rule
                  Container(
                    width: 96,
                    height: 1,
                    color: Colors.white.withOpacity(0.30),
                  ),
                  const SizedBox(height: 32),

                  // Glassmorphic pill subtitle
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.07),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Text(
                          'Curating your digital beauty journey',
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Layer 5: Bottom dot indicators ─────────────────────────────
          Positioned(
            bottom: 52,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(1.0),
                  const SizedBox(width: 8),
                  _dot(0.40),
                  const SizedBox(width: 8),
                  _dot(0.20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(double opacity) => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(opacity),
          shape: BoxShape.circle,
        ),
      );
}
