import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _surfaceHigh = Color(0xFFEDE7DE);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _outlineVariant = Color(0xFFD7C2BE);
  static const _secondaryFixed = Color(0xFFF9DCD6);

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final auth = ref.read(authProvider.notifier);
    await auth.loginWithEmail(_emailCtrl.text.trim(), _passCtrl.text);
    if (!mounted) return;
    final state = ref.read(authProvider);
    if (state.status == AuthStatus.otpSent) {
      context.push('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Botanical top-right accent ──────────────────────────────
            Positioned(
              top: -24,
              right: -24,
              width: 160,
              height: 160,
              child: Opacity(
                opacity: 0.20,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCKyB9D7-T7rjwS3juBaWz7Wt1pQLIKZFCsCZzKKK2oK7tLhJMEBTNc7uagXGpnTe2abTAnP-EouV-XaIBHtWWHdU1CG2jF2FSNje7KkqiMIVXPZ1ukP2mGW1rZQVd0coM4TFVW7AZl_qY9TgmARchir2CpDeRziIrEao2fPf1xrZDWEySykvMHpDdy4lcs0g9cD79D5IE1TvuIfqu5v-sFyX6dO3cA_oH9p6fR2tPEuqpJYthAfLJDlhOJBdJIhEot7CM9w7_ao94',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
            // ── Botanical bottom-left accent ────────────────────────────
            Positioned(
              bottom: -24,
              left: -24,
              width: 120,
              height: 120,
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: 3.14159,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDTinPKWya6_Bbj3iofNwVekjjfnN4uj-GnIC6sQcDMX22oZd4s9TECPqUt5pXKq6YMxoFus9RttfEEtCpZu-8A2-whAigY4DF-ydjOEnIiV8mk3jn-lk2d9rqsUjmUx9SE-g4H9U49eXyyl_BQD0ZxV9NNqjLFLIgmPGVc0PSrtABidh77qZ4lkKn5CD6NESqPAnjI77FExMpHfY6lYrGJP9zOcEmfpDq15eBwKRg2nhg35ZD-ZRj-iYhC3v6etSP6Mo895GP5eu0',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

            // ── Main scrollable content ─────────────────────────────────
            Column(
              children: [
                // Header
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close, color: _onSurface),
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
                      const SizedBox(width: 48), // balance the close button
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // ── Brand identity ───────────────────────────────
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _secondaryFixed,
                            border: Border.all(
                                color: _outlineVariant.withOpacity(0.15)),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC57d2gtixqlghwsNqyWJllLbaXHX6tHYrnrmg-Eq7cqCUI2lYQYOBwSSEW6cBTJDVya2MhrZsqvuOIhDjtvKIrPmF4HUfT-iSWGA3_HV4WQTKtCI1Dk7GNwAzGCXDGFX0HF4dlezXkWPoI2EoT15g3G4Xjmw48I-USjYpPZeFArw3yhJkPqeYDCDMlAkcbNDCxLokUPDpIpMmzAtm-X74CDfD53rWX4TVdz0F7a6VD2jk3giphndA9eAaygAVTkd0Wq1pOKi6ajrQ',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 64,
                                height: 64,
                                color: _primaryContainer,
                                child: const Icon(Icons.spa,
                                    color: Colors.white, size: 32),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rinky Jahan Makeover',
                          style: GoogleFonts.notoSerif(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: _primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Welcome back, beautiful',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                            color: _onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ── Email field ──────────────────────────────────
                        const _FieldLabel(label: 'Email Address'),
                        const SizedBox(height: 6),
                        _TextField(
                          controller: _emailCtrl,
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          surfaceHigh: _surfaceHigh,
                          onSurface: _onSurface,
                          primaryContainer: _primaryContainer,
                        ),
                        const SizedBox(height: 20),

                        // ── Password field ───────────────────────────────
                        const _FieldLabel(label: 'Password'),
                        const SizedBox(height: 6),
                        _TextField(
                          controller: _passCtrl,
                          hint: 'Enter your password',
                          obscureText: _obscurePass,
                          surfaceHigh: _surfaceHigh,
                          onSurface: _onSurface,
                          primaryContainer: _primaryContainer,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _onSurfaceVariant,
                              size: 20,
                            ),
                            onPressed: () =>
                                setState(() => _obscurePass = !_obscurePass),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Login button ─────────────────────────────────
                        _GradientPill(
                          label: 'Login',
                          isLoading: isLoading,
                          primary: _primary,
                          primaryContainer: _primaryContainer,
                          onTap: isLoading ? null : _login,
                        ),
                        const SizedBox(height: 16),

                        // Forgot password
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                              color: _primary.withOpacity(0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ── OR divider ───────────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: _outlineVariant.withOpacity(0.40),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'or',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  color: _onSurfaceVariant,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: _outlineVariant.withOpacity(0.40),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ── Google social button ─────────────────────────
                        _SocialButton(
                          onTap: () {},
                          leading: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCvuKOxAnCqNEV29gWf4SpFuDBANCRvjLlvUds7Jh5sM3KnB55sI2dwlz0eY72ZstqKm9TQI4GEIRhWJIfhwaDVFf1ZCdZCzAV3lJIgeJkx_Ouy7BHiI5slYS6dyIbfiXXgWAeyXnaqd6v2FOe3EkmTPf73WzVCSkeJ8MEmQBUx4SKuRJjJ3zu86EsoYI7fjJ5qEqIEE-PPSTlmAypggVhNAvvNR_b409lxnI_SyPSy1p5a9I6bLvZdQJ4WQsklVBAwK3PCKaJzdcI',
                            width: 20,
                            height: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.g_mobiledata, size: 20),
                          ),
                          label: 'Continue with Google',
                          onSurface: _onSurface,
                          outlineVariant: _outlineVariant,
                        ),
                        const SizedBox(height: 12),

                        // ── Phone social button ──────────────────────────
                        _SocialButton(
                          onTap: () => context.push('/otp'),
                          leading: const Icon(Icons.smartphone, color: _primary),
                          label: 'Continue with Phone Number',
                          onSurface: _onSurface,
                          outlineVariant: _outlineVariant,
                        ),
                        const SizedBox(height: 48),

                        // ── Create account link ──────────────────────────
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.manrope(
                                fontSize: 13, color: _onSurfaceVariant),
                            children: [
                              const TextSpan(text: 'New here? '),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Create an Account',
                                    style: GoogleFonts.manrope(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
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

// ── Shared helper widgets ─────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: const Color(0xFF524341),
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Color surfaceHigh;
  final Color onSurface;
  final Color primaryContainer;

  const _TextField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
    required this.surfaceHigh,
    required this.onSurface,
    required this.primaryContainer,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.manrope(fontSize: 15, color: onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.manrope(
            fontSize: 15, color: onSurface.withOpacity(0.40)),
        filled: true,
        fillColor: surfaceHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryContainer, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        suffixIcon: suffix,
      ),
    );
  }
}

class _GradientPill extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Color primary;
  final Color primaryContainer;
  final VoidCallback? onTap;

  const _GradientPill({
    required this.label,
    required this.isLoading,
    required this.primary,
    required this.primaryContainer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
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
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget leading;
  final String label;
  final Color onSurface;
  final Color outlineVariant;

  const _SocialButton({
    required this.onTap,
    required this.leading,
    required this.label,
    required this.onSurface,
    required this.outlineVariant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border:
              Border.all(color: outlineVariant.withOpacity(0.25), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
