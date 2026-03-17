import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/auth_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneOrEmail;

  const OtpScreen({super.key, this.phoneOrEmail = '+91 XXXXXX'});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  static const _digitCount = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  Timer? _timer;
  int _countdown = 45;

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _secondaryContainer = Color(0xFFF9DCD6);
  static const _outlineVariant = Color(0xFFD7C2BE);

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(_digitCount, (_) => TextEditingController());
    _focusNodes = List.generate(_digitCount, (_) => FocusNode());
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _countdown = 45;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < _digitCount - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verify() async {
    final success =
        await ref.read(authProvider.notifier).verifyOtp(_otp);
    if (!mounted) return;
    if (success) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ref.read(authProvider).errorMessage ?? 'Invalid OTP'),
          backgroundColor: _primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  String get _timerText {
    final m = (_countdown ~/ 60).toString().padLeft(2, '0');
    final s = (_countdown % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(authProvider).status == AuthStatus.loading;
    final filled = _otp.length == _digitCount;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Botanical top-right ─────────────────────────────────────
            Positioned(
              top: -24,
              right: -36,
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Opacity(
                opacity: 0.20,
                child: Transform.rotate(
                  angle: 12 * (3.14159 / 180),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDABDO3kWW0QNMMmZ08npFodGC1yyOijat_ov7eQan04oTOHBS3jdoj8TWZ0exnWNQeuovEzIzDt7RZ3hpoLAz4nsMb5h2gIEBcaq0HjySItBlWg_QSdp8OjCte8WBTZtupyWoMQArgh78CneR8u2RYxEeT_ons7wxNtsdogs_SwHngLczNPOxLhbfjZh3hTVwS7z7L2LhQe09AamaSeUNs69m_JpI___MxhdFAGonwT5Y_CzeK-gZD2rs6iGZxKWrpLSOYOcyD34g',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            // ── Botanical bottom-left ───────────────────────────────────
            Positioned(
              bottom: -24,
              left: -24,
              width: MediaQuery.of(context).size.width * 0.28,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: -45 * (3.14159 / 180),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD15khApNklg-Fm0kbm31PUH3JcevlU5Uu_5Yd4bGVBXh2l-BvqzcZ9ptCQA5SW0OOjQjTgnsKcKO0MmjtzHNzJrwy3Y422KjHKU9ZTtxosApjWubNmu_DIk8Hpawl7p-588k5MWZkm6dO4WxCEDBhlAsnIgztQ_vxWRdUZ96jFesk_pPQW5uUmdcOmcdhSAdOf3vzHV4DQ7kPxK8Pc-4u2RGtT-w0G3iv7jMHTgpjMS8oZ2JWbdfS3R_JxQZxu2XNd8nI-KN64M1w',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

            // ── App bar ─────────────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: _onSurface),
                      onPressed: () =>
                          context.canPop() ? context.pop() : null,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Rinky Jahan Makeover',
                          style: GoogleFonts.notoSerif(
                            fontSize: 17,
                            color: _onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            // ── Main glass card ─────────────────────────────────────────
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.all(36),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.40),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.20)),
                        boxShadow: [
                          BoxShadow(
                            color: _onSurface.withOpacity(0.05),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Phone icon header
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: _secondaryContainer,
                            ),
                            child: const Icon(Icons.phonelink_ring,
                                color: _primary, size: 36),
                          ),
                          const SizedBox(height: 28),

                          // Headlines
                          Text(
                            'Verify Your Number',
                            style: GoogleFonts.notoSerif(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              color: _onSurface,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "We've sent a 6-digit code to ",
                            style: GoogleFonts.manrope(
                                fontSize: 13, color: _onSurfaceVariant),
                          ),
                          Text(
                            widget.phoneOrEmail,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _onSurface,
                            ),
                          ),
                          const SizedBox(height: 36),

                          // ── 6-digit OTP boxes ───────────────────────
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: List.generate(_digitCount, (i) {
                              return _OtpBox(
                                controller: _controllers[i],
                                focusNode: _focusNodes[i],
                                primary: _primary,
                                primaryContainer: _primaryContainer,
                                outlineVariant: _outlineVariant,
                                onChanged: (v) => _onDigitChanged(i, v),
                                onTap: () => _focusNodes[i].requestFocus(),
                              );
                            }),
                          ),
                          const SizedBox(height: 36),

                          // ── Verify button ────────────────────────────
                          GestureDetector(
                            onTap: (filled && !isLoading) ? _verify : null,
                            child: AnimatedOpacity(
                              opacity: filled ? 1.0 : 0.5,
                              duration: const Duration(milliseconds: 250),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [_primary, _primaryContainer],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(999),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _primary.withOpacity(0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2),
                                        )
                                      : Text(
                                          'Verify & Continue',
                                          style: GoogleFonts.manrope(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Resend ───────────────────────────────────
                          Text(
                            "Didn't receive the code?",
                            style: GoogleFonts.manrope(
                                fontSize: 13, color: _onSurfaceVariant),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap:
                                _countdown == 0 ? _startTimer : null,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.timer,
                                    color: _primary, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  _countdown > 0
                                      ? 'Resend OTP in $_timerText'
                                      : 'Resend OTP',
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: _primary,
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
              ),
            ),

            // ── Footer branding ─────────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: Text(
                    'PROFESSIONAL MAKEUP ARTISTRY & ATELIER',
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      letterSpacing: 2.0,
                      color: _onSurface.withOpacity(0.35),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Single OTP digit box ──────────────────────────────────────────────────────

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color primary;
  final Color primaryContainer;
  final Color outlineVariant;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.primary,
    required this.primaryContainer,
    required this.outlineVariant,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 54,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: onChanged,
        style: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1D1B16),
        ),
        decoration: InputDecoration(
          hintText: '·',
          hintStyle: GoogleFonts.manrope(
            fontSize: 22,
            color: const Color(0xFF524341).withOpacity(0.35),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryContainer, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryContainer, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary, width: 2.5),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
