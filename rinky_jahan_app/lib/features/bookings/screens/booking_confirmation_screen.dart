import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const _primary = Color(0xFF894E46);
const _primaryContainer = Color(0xFFC9847A);
const _bg = Color(0xFFFFF9EF);
const _onSurface = Color(0xFF1D1B16);
const _onSurfaceVariant = Color(0xFF524341);
const _secondaryContainer = Color(0xFFF9DCD6);

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        // Botanical watermark
        const Positioned(
          top: 0, left: 0, right: 0, bottom: 0,
          child: Opacity(opacity: 0.04, child: Center(child: Icon(Icons.local_florist, size: 340, color: _primary))),
        ),
        // Header
        Positioned(
          top: 0, left: 0, right: 0,
          child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
            color: _bg.withValues(alpha: 0.82),
            child: SafeArea(bottom: false, child: SizedBox(height: 56, child: Row(children: [
              IconButton(icon: const Icon(Icons.close, color: _onSurface), onPressed: () => context.go('/home')),
              Expanded(child: Center(child: Text('Booking Confirmed', style: GoogleFonts.notoSerif(fontSize: 17, color: _onSurface)))),
              const SizedBox(width: 48),
            ]))),
          ))),
        ),
        // Body
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70, bottom: 120, left: 20, right: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // ── Success icon ─────────────────────────────────────────
            const SizedBox(height: 12),
            Stack(alignment: Alignment.center, children: [
              Container(width: 96, height: 96, decoration: const BoxDecoration(shape: BoxShape.circle, color: _secondaryContainer)),
              Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _primaryContainer.withValues(alpha: 0.22), width: 4))),
              const Icon(Icons.check_circle, color: _primary, size: 52),
            ]),
            const SizedBox(height: 22),
            Text('SUCCESS', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2.0, color: _primary)),
            const SizedBox(height: 8),
            Text('Booking Confirmed!', style: GoogleFonts.notoSerif(fontSize: 34, color: _onSurface)),
            const SizedBox(height: 10),
            Text(
              'Your appointment has been successfully scheduled.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(fontSize: 14, color: _onSurfaceVariant, height: 1.6),
            ),
            const SizedBox(height: 32),

            // ── Summary card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _secondaryContainer,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 30, offset: const Offset(0, 14))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Service
                Text('SERVICE', style: GoogleFonts.manrope(fontSize: 9, letterSpacing: 1.8, fontWeight: FontWeight.w700, color: const Color(0xFF75605B))),
                const SizedBox(height: 4),
                Text('Royal Facial & Glow Treatment', style: GoogleFonts.notoSerif(fontSize: 20, color: const Color(0xFF4F201A))),
                const SizedBox(height: 24),
                // 2-col details
                const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: _DetailItem(icon: Icons.calendar_today, label: 'DATE & TIME', value: 'Oct 14, 09:00 AM')),
                  SizedBox(width: 16),
                  Expanded(child: _DetailItem(icon: Icons.face, label: 'STYLIST', value: 'Amelia')),
                ]),
                const SizedBox(height: 20),
                // Location
                const _DetailItem(icon: Icons.location_on, label: 'LOCATION', value: '123 Beauty Lane, Atelier District', wide: true),
                const SizedBox(height: 22),
                // Divider
                Divider(color: _onSurface.withValues(alpha: 0.06), height: 1),
                const SizedBox(height: 16),
                // Price row
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('PRICE PAID', style: GoogleFonts.manrope(fontSize: 9, letterSpacing: 1.8, fontWeight: FontWeight.w700, color: const Color(0xFF75605B))),
                    const SizedBox(height: 4),
                    Text('₹1,499', style: GoogleFonts.notoSerif(fontSize: 28, color: _primaryContainer)),
                  ]),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: _primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(999)),
                    child: Text('PREPAID', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: _primary)),
                  ),
                ]),
              ]),
            ),
            const SizedBox(height: 32),

            // ── Action buttons ───────────────────────────────────────
            GestureDetector(
              onTap: () => context.go('/my-bookings'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_primary, _primaryContainer]),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [BoxShadow(color: _primaryContainer.withValues(alpha: 0.30), blurRadius: 18, offset: const Offset(0, 8))],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('View My Bookings', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ]),
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () => context.go('/home'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), border: Border.all(color: const Color(0xFFD7C2BE).withValues(alpha: 0.35))),
                child: Text('Go to Home', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w600, color: _onSurface)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool wide;
  const _DetailItem({required this.icon, required this.label, required this.value, this.wide = false});

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Icon(icon, size: 13, color: _primary),
      const SizedBox(width: 6),
      Text(label, style: GoogleFonts.manrope(fontSize: 9, letterSpacing: 1.6, fontWeight: FontWeight.w700, color: const Color(0xFF75605B))),
    ]),
    const SizedBox(height: 4),
    Text(value, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600, color: _onSurface)),
  ]);
}
