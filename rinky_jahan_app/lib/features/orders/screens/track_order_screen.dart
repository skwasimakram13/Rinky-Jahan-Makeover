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
const _surfaceHighest = Color(0xFFE7E2D9);
const _outlineVariant = Color(0xFFD7C2BE);

enum _OrderStatus { placed, processing, shipped, delivery }

class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  const TrackOrderScreen({super.key, this.orderId = 'RJ88291'});

  static const _items = [
    _OrderItem('Rose Glow Serum', '30ml / Anti-Aging', '₹1,499',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB3E4nrKuMCVd0NNPTNNXlysP1AVvSZwPDPOM3wYxvLaIpDWZgNCB2P_oLG1h3UeViiAeyRgKjCL5H0a7igByImtmy766SagaBly7eOIpot3XqdQhnC9FLnUsGeNPb8suW--LOKYAPjltGJtcg8RTuGM4WGbdEL9hpJe0oW9jfOAjKjzl1xkIGMcm3DSGZC0vA6FzxrPSHbIIGvgnapWZrMNrOTxW3BcCw69-ZVTGLCViAvNmbWMy5GJUxFfybDqXq02O0c7whwDIs'),
    _OrderItem('Velvet Night Cream', '50g / Deep Repair', '₹2,150',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBAZVHJDLTMepzhmi1gLqJZ7ToC2VxZE5ky3pitkyPvb84M6sI768IHVOrLJ1tfj_upPKutX0zk6A68Zgv28LlJQ2WLTEgjRc0OX6oo-y510ykipRdEpisaXWQYcPUzZwwYe2ts8mYlw5guLV3RKqSmuYNaettKgb3SdWUvJ98SslClEPq7wXqGsrdQ6TyQygs5ESIz4vf3gGZzYDvn42MDllls4zjvfieKvroe6BdKsHk24TW0Fcv2t9COy5k4dpixWMxa7zZeX8o'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          // ── Glassmorphic header ─────────────────────────────────────
          SliverPersistentHeader(pinned: true, delegate: _TrackBarDelegate(orderId: orderId, onBack: () => Navigator.of(context).maybePop())),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // ── Delivery ETA card ─────────────────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _secondaryContainer,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _outlineVariant.withValues(alpha: 0.15)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 28, offset: const Offset(0, 10))],
                ),
                child: Stack(children: [
                  const Positioned(right: -14, top: -14, child: Opacity(opacity: 0.08, child: Icon(Icons.spa, size: 100, color: _onSurface))),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('ESTIMATED ARRIVAL', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.6, color: const Color(0xFF75605B))),
                    const SizedBox(height: 6),
                    Text('Arriving by Thursday, Oct 24', style: GoogleFonts.notoSerif(fontSize: 20, color: _onSurface, height: 1.25)),
                    const SizedBox(height: 4),
                    Text('Estimated time: 10:00 AM – 2:00 PM', style: GoogleFonts.manrope(fontSize: 13, color: const Color(0xFF75605B))),
                  ]),
                ]),
              ),
              const SizedBox(height: 32),

              // ── Tracking timeline ──────────────────────────────────
              Text('Tracking Status', style: GoogleFonts.notoSerif(fontSize: 18, color: _onSurface)),
              const SizedBox(height: 20),
              const _TrackingTimeline(),
              const SizedBox(height: 32),

              // ── Shipping details ───────────────────────────────────
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: _surfaceLow, borderRadius: BorderRadius.circular(16)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _ShipDetail(
                    icon: Icons.location_on_outlined,
                    label: 'DELIVERY ADDRESS',
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Priya Singh', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _onSurface)),
                      const SizedBox(height: 2),
                      Text('123 Beauty Lane, Sector 45\nGurugram, Haryana, 122003', style: GoogleFonts.manrope(fontSize: 13, color: _onSurface, height: 1.5)),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  _ShipDetail(
                    icon: Icons.speed_outlined,
                    label: 'SHIPPING METHOD',
                    child: Text('Standard Delivery (3-5 Business Days)', style: GoogleFonts.manrope(fontSize: 13, color: _onSurface)),
                  ),
                ]),
              ),
              const SizedBox(height: 32),

              // ── Order items ────────────────────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Order Summary', style: GoogleFonts.notoSerif(fontSize: 18, color: _onSurface)),
                Text('${_items.length} Items', style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant)),
              ]),
              const SizedBox(height: 14),
              ..._items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(width: 60, height: 60, child: Image.network(item.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: _secondaryContainer)))),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.name, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600, color: _onSurface)),
                      Text(item.variant, style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant)),
                    ])),
                    Text(item.price, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _onSurface)),
                  ]),
                ),
              )),
              const SizedBox(height: 24),

              // ── Support buttons ────────────────────────────────────
              Row(children: [
                Expanded(child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined, size: 16),
                  label: Text('Call Support', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(foregroundColor: _primary, side: const BorderSide(color: _primaryContainer), padding: const EdgeInsets.symmetric(vertical: 14), shape: const StadiumBorder()),
                )),
                const SizedBox(width: 14),
                Expanded(child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 16),
                  label: Text('Chat with Us', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(foregroundColor: _primary, side: const BorderSide(color: _primaryContainer), padding: const EdgeInsets.symmetric(vertical: 14), shape: const StadiumBorder()),
                )),
              ]),
            ])),
          ),
        ]),
      ]),
    );
  }
}

// ── Tracking timeline ──────────────────────────────────────────────────────

class _TrackingTimeline extends StatelessWidget {
  const _TrackingTimeline();

  static const _steps = [
    _TimelineStep('Order Placed', 'Oct 20, 09:45 AM', _OrderStatus.placed, true),
    _TimelineStep('Processing', 'Oct 21, 02:30 PM', _OrderStatus.processing, true),
    _TimelineStep('Shipped', 'In transit – Near New Delhi Facility', _OrderStatus.shipped, true),
    _TimelineStep('Out for Delivery', 'Expected by Thursday morning', _OrderStatus.delivery, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(_steps.length, (i) {
      final s = _steps[i];
      final isLast = i == _steps.length - 1;
      final isCurrent = i == 2; // shipped = active
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Dot + line column
        SizedBox(width: 32, child: Column(children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: s.done ? (isCurrent ? _primary : _primaryContainer) : _surfaceHighest,
              boxShadow: isCurrent ? [BoxShadow(color: _primaryContainer.withValues(alpha: 0.4), blurRadius: 10, spreadRadius: 2)] : null,
            ),
            child: s.done
                ? Icon(isCurrent ? Icons.local_shipping : Icons.check, color: Colors.white, size: 15)
                : Center(child: Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: _outlineVariant))),
          ),
          if (!isLast) Container(width: 2, height: 46, color: s.done && !isCurrent ? _primaryContainer : _surfaceHighest),
        ])),
        const SizedBox(width: 18),
        Expanded(child: Padding(
          padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 16),
          child: Opacity(opacity: s.done ? 1.0 : 0.5, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.label, style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, color: isCurrent ? _primary : _onSurface)),
            const SizedBox(height: 2),
            Text(s.sublabel, style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant, fontStyle: isCurrent ? FontStyle.italic : FontStyle.normal)),
          ])),
        )),
      ]);
    }));
  }
}

class _TimelineStep {
  final String label, sublabel;
  final _OrderStatus status;
  final bool done;
  const _TimelineStep(this.label, this.sublabel, this.status, this.done);
}

// ── Ship detail ───────────────────────────────────────────────────────────────

class _ShipDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;
  const _ShipDetail({required this.icon, required this.label, required this.child});

  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: _primaryContainer, size: 20),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: _onSurfaceVariant)),
      const SizedBox(height: 4),
      child,
    ])),
  ]);
}

// ── Order item data ───────────────────────────────────────────────────────────

class _OrderItem {
  final String name, variant, price, imageUrl;
  const _OrderItem(this.name, this.variant, this.price, this.imageUrl);
}

// ── App bar delegate ──────────────────────────────────────────────────────────

class _TrackBarDelegate extends SliverPersistentHeaderDelegate {
  final String orderId;
  final VoidCallback onBack;
  _TrackBarDelegate({required this.orderId, required this.onBack});
  @override double get minExtent => 60;
  @override double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox.expand(child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
        color: _bg.withValues(alpha: 0.84),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: _onSurface), onPressed: onBack),
          Expanded(child: Text('Order #$orderId', style: GoogleFonts.notoSerif(fontSize: 17, color: _onSurface))),
          IconButton(icon: const Icon(Icons.more_vert, color: _onSurface), onPressed: () {}),
        ]),
      ))));

  @override bool shouldRebuild(covariant _TrackBarDelegate old) => false;
}
