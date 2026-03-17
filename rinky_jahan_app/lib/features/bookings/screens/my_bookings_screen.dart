import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primary = Color(0xFF894E46);
const _primaryContainer = Color(0xFFC9847A);
const _bg = Color(0xFFFFF9EF);
const _onSurface = Color(0xFF1D1B16);
const _onSurfaceVariant = Color(0xFF524341);
const _secondaryContainer = Color(0xFFF9DCD6);
const _surfaceLow = Color(0xFFF9F3EA);
const _tertiary = Color(0xFF2C6959);

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

enum _Tab { upcoming, past, cancelled }

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  _Tab _tab = _Tab.upcoming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        // Botanical accent
        Positioned(
          right: -50, top: MediaQuery.of(context).size.height * 0.2,
          child: const Opacity(opacity: 0.07, child: Icon(Icons.filter_vintage, size: 280, color: _primary)),
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverPersistentHeader(pinned: true, delegate: _BookingsBarDelegate(onBack: () => Navigator.of(context).maybePop())),
            // Tabs
            SliverToBoxAdapter(child: _buildTabs()),
            // Content
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              sliver: SliverList(delegate: SliverChildListDelegate(_buildContent())),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: const Color(0xFFD7C2BE).withValues(alpha: 0.15)))),
      child: Row(children: _Tab.values.map((t) {
        final active = t == _tab;
        final label = t.name[0].toUpperCase() + t.name.substring(1);
        return Expanded(child: GestureDetector(
          onTap: () => setState(() => _tab = t),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: active ? const BoxDecoration(border: Border(bottom: BorderSide(color: _primary, width: 2.5))) : null,
            child: Center(child: Text(label, style: GoogleFonts.manrope(fontSize: 14, fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: active ? _primary : _onSurfaceVariant.withValues(alpha: 0.6)))),
          ),
        ));
      }).toList()),
    );
  }

  List<Widget> _buildContent() {
    if (_tab == _Tab.upcoming) {
      return [
        Text('YOUR SANCTUARY', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2.0, color: _primary)),
        const SizedBox(height: 6),
        Text('Confirmed Visits', style: GoogleFonts.notoSerif(fontSize: 26, color: _onSurface)),
        const SizedBox(height: 20),
        _BookingCard(
          title: 'Bridal Makeover',
          subtitle: 'by Rinky Jahan',
          date: 'Oct 28, 2024 at 10:00 AM',
          status: 'Confirmed',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVtc8OiXc6GKqOLRaQpp1AMy8gGgue6sVg1tUyxF3HxptN5gBhXuUs-kzYI42-JLwvNn0RKc3T_QSqEMUNL2M05ec-gJHYvA71Ob4iZbLYPfIaokHrfS3QHHAy5ifrrt39rkoLwHwt1eakOjm_sliFIitrLnKMwry4R36XhsvwjkHlvkKoIu4nIYym27ciZk8kRcTsUCGPDbLxUujOGUtpGM2_qECNKMfjJfvmlTspRRXnLEhW4kX1z2U_-WzBXmDUF_io8th2x3I',
          onReschedule: () {}, onCancel: () {},
        ),
        const SizedBox(height: 16),
        _BookingCard(
          title: 'Royal Facial',
          subtitle: 'by Rinky Jahan',
          date: 'Nov 05, 2024 at 02:30 PM',
          status: 'Confirmed',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAR4AQoXLqDwloEDXh3SBQMZS5OjedDamEnGorWjCx9ZsshinF7-PAu5bCKj4eisz37MHGxWRu4RdiWkVzw6uwDw25vcg13h3RGLP6OHbCZdjo-j2Yy6kpLewsQPt9vBzFRQNMKIqAfRp4LitlZcXCauEOQree0v43onH-tiW048-MZRPYAnqZHLd35QS33IhsrrC3ox4g0UDfZ-2TEg3sg97lJQ1GL8a8v2U8zMm88jig9bSiffNrilL3GiTj2tLd1phA41b6r5Sw',
          onReschedule: () {}, onCancel: () {},
        ),
        const SizedBox(height: 32),
        // Past preview
        Container(height: 1, color: const Color(0xFFD7C2BE).withValues(alpha: 0.2)),
        const SizedBox(height: 24),
        Text('MEMORIES', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2.0, color: _primaryContainer)),
        const SizedBox(height: 6),
        Text('Past Experiences', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
        const SizedBox(height: 16),
        _PastCard(
          title: 'Classic Manicure',
          stars: 5,
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBn4GhQbRGqN3bkiIbSa8kkE5p8tOezuRlbUYKJf08nZx0uHJhMBJJnoMwVIeR-JT89_-bty6cS3KJKj4ASEwctRHlE5ixPaGsaLz3cBGxIoFgHKZ-f1PmkLmotKV-3EFGicwErLmm8zX634XXfbrrpSNn1wO2_O6985VK860WVnPrbYRFARvf8oot2AHyinMOJUkAUrDcIhD3y8BPPaKfr_C3eAIL531W2tCNUZjQ5DW_-Y8xKXS5v3y0utgnPmRQqug0qSVdshyU',
          onBookAgain: () {},
        ),
      ];
    } else if (_tab == _Tab.past) {
      return [
        Text('MEMORIES', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2.0, color: _primaryContainer)),
        const SizedBox(height: 6),
        Text('Past Experiences', style: GoogleFonts.notoSerif(fontSize: 26, color: _onSurface)),
        const SizedBox(height: 20),
        _PastCard(title: 'Classic Manicure', stars: 5, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBn4GhQbRGqN3bkiIbSa8kkE5p8tOezuRlbUYKJf08nZx0uHJhMBJJnoMwVIeR-JT89_-bty6cS3KJKj4ASEwctRHlE5ixPaGsaLz3cBGxIoFgHKZ-f1PmkLmotKV-3EFGicwErLmm8zX634XXfbrrpSNn1wO2_O6985VK860WVnPrbYRFARvf8oot2AHyinMOJUkAUrDcIhD3y8BPPaKfr_C3eAIL531W2tCNUZjQ5DW_-Y8xKXS5v3y0utgnPmRQqug0qSVdshyU', onBookAgain: () {}),
        const SizedBox(height: 12),
        _PastCard(title: 'Royal Facial', stars: 5, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAR4AQoXLqDwloEDXh3SBQMZS5OjedDamEnGorWjCx9ZsshinF7-PAu5bCKj4eisz37MHGxWRu4RdiWkVzw6uwDw25vcg13h3RGLP6OHbCZdjo-j2Yy6kpLewsQPt9vBzFRQNMKIqAfRp4LitlZcXCauEOQree0v43onH-tiW048-MZRPYAnqZHLd35QS33IhsrrC3ox4g0UDfZ-2TEg3sg97lJQ1GL8a8v2U8zMm88jig9bSiffNrilL3GiTj2tLd1phA41b6r5Sw', onBookAgain: () {}),
      ];
    } else {
      return [
        const SizedBox(height: 60),
        Center(child: Column(children: [
          Icon(Icons.event_busy_outlined, size: 64, color: _onSurfaceVariant.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text('No cancelled bookings', style: GoogleFonts.manrope(fontSize: 15, color: _onSurfaceVariant)),
        ])),
      ];
    }
  }
}

class _BookingCard extends StatelessWidget {
  final String title, subtitle, date, status, imageUrl;
  final VoidCallback onReschedule, onCancel;
  const _BookingCard({required this.title, required this.subtitle, required this.date, required this.status, required this.imageUrl, required this.onReschedule, required this.onCancel});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: _secondaryContainer, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 24, offset: const Offset(0, 8))]),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(borderRadius: BorderRadius.circular(12), child: SizedBox(width: 88, height: 88, child: Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: _surfaceLow)))),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.notoSerif(fontSize: 17, fontWeight: FontWeight.w700, color: _onSurface)),
            Text(subtitle, style: GoogleFonts.manrope(fontSize: 12, color: _onSurfaceVariant)),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: _tertiary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(999)),
            child: Row(children: [
              const Icon(Icons.check_circle, color: _tertiary, size: 12),
              const SizedBox(width: 4),
              Text(status, style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, color: _tertiary, letterSpacing: 0.6)),
            ]),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          const Icon(Icons.calendar_today, size: 13, color: _onSurfaceVariant),
          const SizedBox(width: 6),
          Flexible(child: Text(date, style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500, color: _onSurfaceVariant))),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          OutlinedButton(onPressed: onReschedule, style: OutlinedButton.styleFrom(foregroundColor: _primary, side: const BorderSide(color: _primary), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), shape: const StadiumBorder()), child: Text('Reschedule', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700))),
          const SizedBox(width: 6),
          TextButton(onPressed: onCancel, style: TextButton.styleFrom(foregroundColor: _onSurfaceVariant, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), shape: const StadiumBorder()), child: Text('Cancel', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600))),
        ]),
      ])),
    ]),
  );
}

class _PastCard extends StatelessWidget {
  final String title, imageUrl;
  final int stars;
  final VoidCallback onBookAgain;
  const _PastCard({required this.title, required this.imageUrl, required this.stars, required this.onBookAgain});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: _surfaceLow, borderRadius: BorderRadius.circular(18)),
    child: Row(children: [
      ClipRRect(borderRadius: BorderRadius.circular(10), child: ColorFiltered(colorFilter: const ColorFilter.matrix([0.2126,0.7152,0.0722,0,0,0.2126,0.7152,0.0722,0,0,0.2126,0.7152,0.0722,0,0,0,0,0,1,0]), child: SizedBox(width: 72, height: 72, child: Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE0DAD2)))))),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.notoSerif(fontSize: 15, fontWeight: FontWeight.w700, color: _onSurface)),
        const SizedBox(height: 4),
        Row(children: List.generate(stars, (_) => const Icon(Icons.star, color: _primaryContainer, size: 14))),
      ])),
      ElevatedButton.icon(
        onPressed: onBookAgain,
        icon: const Icon(Icons.refresh, size: 13),
        label: Text('Book Again', style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(backgroundColor: _primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), shape: const StadiumBorder()),
      ),
    ]),
  );
}

class _BookingsBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onBack;
  _BookingsBarDelegate({required this.onBack});
  @override double get minExtent => 60;
  @override double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
      color: _bg.withValues(alpha: 0.84),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(children: [
        IconButton(icon: const Icon(Icons.arrow_back, color: _onSurface), onPressed: onBack),
        Expanded(child: Center(child: Text('My Bookings', style: GoogleFonts.notoSerif(fontSize: 19, color: _onSurface)))),
        IconButton(icon: const Icon(Icons.more_vert, color: _primary), onPressed: () {}),
      ]),
    ))));
  }
  @override bool shouldRebuild(covariant _BookingsBarDelegate old) => false;
}
