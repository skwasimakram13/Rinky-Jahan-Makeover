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
const _surfaceLow = Color(0xFFF9F3EA);
const _surfaceHighest = Color(0xFFE7E2D9);
const _surfaceVariant = Color(0xFFE7E2D9);
const _outlineVariant = Color(0xFFD7C2BE);
const _tertiary = Color(0xFF2C6959);

enum _PayMethod { upi, card, cod, netBanking }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _PayMethod _method = _PayMethod.upi;

  static const _items = [
    _CheckItem('Rose Glow Serum', '30ml • Qty: 1', '₹1,250',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDdsM-pTmz1ITElGp1RNqTgFCFngCG1S-9O_hmEBi63sCOunUJa3Zhu6vYb5CEXlVTD3nx7OHFMgKK7wvxbNxz1bVY5-_MZK2-wpjZIM5wujckj1DflyA0f3ra1XJeQ50BU8_4sjsU3s_PSrH5ijsECuFNngINrLM2GNXCzaflg_EkvY9k9FaxvQYoK3kl8mwP9vt1mnSPd5R6-vkcNppAbUG6G7ySnHFwVqyG91_B7DpH0ywZ6y6xiCGdHxwsaD2D63gwQHwVlA2w'),
    _CheckItem('Velvet Night Cream', '50g • Qty: 1', '₹899',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBHMLdPEKqIMOpgMewbVMRrL1OUkhiR7jAmVUCuPdrP9Ra1Nzps56JvT3atoIFb058hMdlwc3xP1z833hYZCB7Q-zQ0JPjEfXNWvVj83Da8ciDLNkPkhpqSCDPZto7Egdh06UTrZeDCXH9nKgL7Uv7PB68AG27nt-cgndS-ZBWhiXLdN5n57DT_BYmHW19KiLxs62BNtFftNGZj66DDroAWyrMyMf0hl1rcLQ-9wdsI0wnWQCuGXOdMVhSge6ZwNH7z489POZjRKHs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          // Header
          SliverPersistentHeader(pinned: true, delegate: _CheckBarDelegate(onBack: () => Navigator.of(context).maybePop())),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // ── Delivery Address ───────────────────────────────────
              Text('YOUR SANCTUARY', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.6, color: _onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('Delivery Address', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: _secondaryContainer,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 24, offset: const Offset(0, 8))],
                ),
                child: Stack(children: [
                  const Positioned(right: -4, bottom: -4, child: Opacity(opacity: 0.08, child: Icon(Icons.local_florist, size: 80, color: _onSurface))),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Priya Singh', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: _onSurface)),
                      const SizedBox(height: 4),
                      Text('123 Beauty Lane, Apartment 4B,\nAtelier District, New Delhi – 110001', style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVariant, height: 1.55)),
                    ])),
                    TextButton(onPressed: () {}, child: Text('Edit', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _primary))),
                  ]),
                ]),
              ),
              const SizedBox(height: 10),
              // Add address button
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _outlineVariant, style: BorderStyle.solid, width: 1.5),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.add, color: _primary, size: 18),
                    const SizedBox(width: 6),
                    Text('Add New Address', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _primary)),
                  ]),
                ),
              ),
              const SizedBox(height: 30),

              // ── Order summary (horizontal scroll) ──────────────────
              Text('THE COLLECTION', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.6, color: _onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('Order Summary', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 14),
              SizedBox(height: 100, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: _items.length,
                itemBuilder: (_, i) {
                  final item = _items[i];
                  return Container(
                    width: 260,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: _surfaceLow, borderRadius: BorderRadius.circular(14)),
                    child: Row(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(width: 72, height: 72, child: Image.network(item.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: _secondaryContainer)))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(item.name, style: GoogleFonts.notoSerif(fontSize: 13, color: _onSurface)),
                        Text(item.variant, style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant)),
                        const SizedBox(height: 4),
                        Text(item.price, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _onSurface)),
                      ])),
                    ]),
                  );
                },
              )),
              const SizedBox(height: 30),

              // ── Payment Method ──────────────────────────────────────
              Text('SECURE CHECKOUT', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.6, color: _onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('Payment Method', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 14),
              ...[
                const _PayOption(_PayMethod.upi, Icons.account_balance_wallet, 'UPI', 'GPay • PhonePe'),
                const _PayOption(_PayMethod.card, Icons.credit_card, 'Debit/Credit Card', 'Visa, Mastercard, Amex'),
                const _PayOption(_PayMethod.cod, Icons.payments_outlined, 'Cash on Delivery', 'Pay at your doorstep'),
                const _PayOption(_PayMethod.netBanking, Icons.account_balance_outlined, 'Net Banking', 'All major banks supported'),
              ].map((opt) {
                final sel = _method == opt.method;
                return GestureDetector(
                  onTap: () => setState(() => _method = opt.method),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: sel ? _surfaceHighest : _surfaceLow,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: sel ? _primary : Colors.transparent, width: 2),
                      boxShadow: sel ? [BoxShadow(color: _primaryContainer.withValues(alpha: 0.08), blurRadius: 12)] : null,
                    ),
                    child: Row(children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: sel ? _primary : _surfaceVariant),
                        child: Icon(opt.icon, color: sel ? Colors.white : _onSurfaceVariant, size: 18),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(opt.label, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: _onSurface)),
                        Text(opt.sub, style: GoogleFonts.manrope(fontSize: 10, color: _onSurfaceVariant)),
                      ])),
                      Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: sel ? _primary : _outlineVariant, width: 2)),
                        child: sel ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: _primary))) : const SizedBox.shrink(),
                      ),
                    ]),
                  ),
                );
              }),
              const SizedBox(height: 30),

              // ── Price breakdown ─────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: _surfaceLow, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const _PriceRow('Subtotal', '₹2,149'),
                  const SizedBox(height: 10),
                  const _PriceRow('Discount', '-₹200', color: _tertiary),
                  const SizedBox(height: 10),
                  const _PriceRow('Delivery', 'FREE'),
                  const SizedBox(height: 10),
                  const _PriceRow('GST (18%)', '₹350'),
                  Divider(color: _outlineVariant.withValues(alpha: 0.5), height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Total', style: GoogleFonts.notoSerif(fontSize: 19, fontWeight: FontWeight.w700, color: _onSurface)),
                    Text('₹2,299', style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.w700, color: _onSurface)),
                  ]),
                ]),
              ),
            ])),
          ),
        ]),

        // ── Sticky Place Order bar ──────────────────────────────────────
        Positioned(bottom: 0, left: 0, right: 0,
          child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
            color: _bg.withValues(alpha: 0.85),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            child: GestureDetector(
              onTap: () => context.go('/booking-confirmation'),
              child: Container(
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_primary, _primaryContainer]),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [BoxShadow(color: _primaryContainer.withValues(alpha: 0.28), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Place Order', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.lock, color: Colors.white, size: 16),
                ]),
              ),
            ),
          ))),
        ),
      ]),
    );
  }
}

class _PayOption {
  final _PayMethod method;
  final IconData icon;
  final String label, sub;
  const _PayOption(this.method, this.icon, this.label, this.sub);
}

class _CheckItem {
  final String name, variant, price, imageUrl;
  const _CheckItem(this.name, this.variant, this.price, this.imageUrl);
}

class _PriceRow extends StatelessWidget {
  final String label, value;
  final Color? color;
  const _PriceRow(this.label, this.value, {this.color});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVariant)),
    Text(value, style: GoogleFonts.manrope(fontSize: 13, color: color ?? _onSurfaceVariant, fontWeight: color != null ? FontWeight.w700 : FontWeight.normal)),
  ]);
}

class _CheckBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onBack;
  _CheckBarDelegate({required this.onBack});
  @override double get minExtent => 60;
  @override double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
        color: _bg.withValues(alpha: 0.85),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SafeArea(bottom: false, child: Row(children: [
          IconButton(
            icon: Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF9F3EA)), child: const Icon(Icons.arrow_back, color: _primary, size: 17)),
            onPressed: onBack,
          ),
          Expanded(child: Center(child: Text('Checkout', style: GoogleFonts.notoSerif(fontSize: 18, color: _onSurface)))),
          const SizedBox(width: 48),
        ])),
      )));

  @override bool shouldRebuild(covariant _CheckBarDelegate old) => false;
}
