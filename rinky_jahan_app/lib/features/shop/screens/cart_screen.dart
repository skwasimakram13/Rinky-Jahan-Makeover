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
const _surfaceHighest = Color(0xFFE7E2D9);
const _tertiary = Color(0xFF2C6959);

class _CartItem {
  final String name;
  final String variant;
  final String imageUrl;
  final int priceEach;
  int qty = 1;
  _CartItem({required this.name, required this.variant, required this.imageUrl, required this.priceEach});
  int get total => priceEach * qty;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<_CartItem> _items = [
    _CartItem(name: 'Rose Glow Serum', variant: '30ml', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBnU8rGpXoYtKVD6f_yMMvaju89x1KXTZdQOGT5ta7tkYxlD3bsAM0Zwtf5ZfQcn9cWY7awSjm4pwDbOLbgIQvVQtujwPCSYRAS7AoFqP3yiPVkG-o_Q9-bKCN9ES9TRaz_GQBZSrQxkCTxmnjANTJpSWS2vHd1Bkwqkv7Raeahb7FHL0SvNBlypekxrWs36Jrkgq-0icaO_IyZwPcwfBebRiCYnod8S_nGs1dWApIT6WMf94izn7S0-tfu75ZeusY1IFpjabV_XR4', priceEach: 899),
    _CartItem(name: 'Velvet Night Cream', variant: '50ml', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuApfTl2P45R0Wv0fxqrU7jnBBmWoDQ1a4ksjBb2qVWgt2Ls77Po--QthyHoj3MVBTLxiWETaT22nsIFJX6gCukFm6Ip3Vt_rbBktZ6VkaA7Y2DigjNE9PRQOPD6LiCkOGhtB2DyLJJOyZrxIZxGPis50H_B7R1M_O2l9r0-HmHUN-6YI1BmcIkS4XOIU6jtCFXpnPGuOn_79wflk8R8Pis8dbUs4eg4gS4VGzDsDMBclWvaSUzw9RVT6UqJ0kSxy49mV947aIvvYww', priceEach: 1250),
    _CartItem(name: 'Radiance Mask', variant: '100ml', imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAP59IqM1rIPgMqKidA8Bu25EtAnmGfZHPX8x9y_6MXoc2w__Y8Gfny2jgf8JM7HyrcUzdUlRTaba4WnoLl4CY1iEOsYrUHmBmgieVQeyp5BC8NSlG0KE9Fr8kFb9P1MoOzeXG9JdrbhiVEWLm9nIedZW2bvDtppO4VH87VoMEjlg0n2Xc0MP_sqh1GsdIogVH7_BJEeOn1MrglLYGN4YgmMQlGDrvEd_EAX8GAU0uDg3U5dUEuWzlhFpUVnamsSpuLdJneEkkU22c', priceEach: 750),
  ];
  final _couponCtrl = TextEditingController();
  int get _subtotal => _items.fold(0, (s, i) => s + i.total);
  int get _total => _subtotal - 200;

  @override
  void dispose() { _couponCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: _CartBarDelegate(count: _items.length, onBack: () => Navigator.of(context).maybePop())),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
              sliver: SliverList(delegate: SliverChildListDelegate([
                Text('YOUR SELECTION', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.8, color: _onSurfaceVariant.withValues(alpha: 0.6))),
                const SizedBox(height: 14),
                ..._items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ItemCard(item: item, onRemove: () => setState(() => _items.remove(item)), onQty: (v) => setState(() => item.qty = v)),
                )),
                const SizedBox(height: 16),
                Text('PROMOTIONS', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.8, color: _onSurfaceVariant.withValues(alpha: 0.6))),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFF9F3EA), borderRadius: BorderRadius.circular(999)),
                  child: Row(children: [
                    Expanded(child: TextField(controller: _couponCtrl, decoration: InputDecoration(hintText: 'Enter coupon code', hintStyle: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVariant.withValues(alpha: 0.4)), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 18)))),
                    GestureDetector(
                      onTap: () {},
                      child: Container(margin: const EdgeInsets.all(5), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)), child: Text('Apply', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: _primary))),
                    ),
                  ]),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(color: _secondaryContainer, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 28, offset: const Offset(0, 10))]),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Order Summary', style: GoogleFonts.notoSerif(fontSize: 18, color: _onSurface)),
                    Divider(color: _onSurface.withValues(alpha: 0.05), height: 22),
                    _Row('Subtotal', '₹$_subtotal'),
                    const SizedBox(height: 8),
                    const _Row('Discount', '-₹200', color: _tertiary),
                    const SizedBox(height: 8),
                    const _Row('Delivery', 'FREE'),
                    Divider(color: _onSurface.withValues(alpha: 0.05), height: 22),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Total Amount', style: GoogleFonts.notoSerif(fontSize: 17, color: _onSurface)),
                      Text('₹$_total', style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.w700, color: _primary)),
                    ]),
                  ]),
                ),
              ])),
            ),
          ],
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: _bg.withValues(alpha: 0.80),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
                child: GestureDetector(
                  onTap: () => context.go('/booking-confirmation'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [_primary, _primaryContainer]),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [BoxShadow(color: _primaryContainer.withValues(alpha: 0.30), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    child: Text('Proceed to Checkout', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final _CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQty;
  const _ItemCard({required this.item, required this.onRemove, required this.onQty});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: _secondaryContainer, borderRadius: BorderRadius.circular(18)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ClipRRect(borderRadius: BorderRadius.circular(12), child: SizedBox(width: 80, height: 80, child: Image.network(item.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.white38)))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.name, style: GoogleFonts.notoSerif(fontSize: 15, color: _onSurface)),
        Text(item.variant, style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant)),
        const SizedBox(height: 8),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(color: _surfaceHighest, borderRadius: BorderRadius.circular(999)),
            child: Row(children: [
              _Btn(icon: Icons.remove, onTap: () { if (item.qty > 1) onQty(item.qty - 1); }),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('${item.qty}', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700))),
              _Btn(icon: Icons.add, onTap: () => onQty(item.qty + 1)),
            ]),
          ),
          const Spacer(),
          Text('₹${item.total}', style: GoogleFonts.notoSerif(fontSize: 16, fontWeight: FontWeight.w700, color: _onSurface)),
        ]),
      ])),
      GestureDetector(onTap: onRemove, child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.close, size: 15, color: Color(0x60524341)))),
    ]),
  );
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Btn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: SizedBox(width: 26, height: 26, child: Icon(icon, size: 15, color: _onSurface)));
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _Row(this.label, this.value, {this.color});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVariant)),
    Text(value, style: GoogleFonts.manrope(fontSize: 13, color: color ?? _onSurfaceVariant, fontWeight: color != null ? FontWeight.w700 : FontWeight.normal)),
  ]);
}

class _CartBarDelegate extends SliverPersistentHeaderDelegate {
  final int count;
  final VoidCallback onBack;
  _CartBarDelegate({required this.count, required this.onBack});
  @override double get minExtent => 60;
  @override double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
      color: _bg.withValues(alpha: 0.83),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SafeArea(bottom: false, child: Row(children: [
        IconButton(icon: Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: _surfaceHighest), child: const Icon(Icons.arrow_back, color: _onSurface, size: 17)), onPressed: onBack),
        Expanded(child: Center(child: Text('My Cart ($count)', style: GoogleFonts.notoSerif(fontSize: 17, color: _onSurface)))),
        IconButton(icon: Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: _surfaceHighest), child: const Icon(Icons.more_vert, color: _onSurface, size: 17)), onPressed: () {}),
      ])),
    )));
  }
  @override bool shouldRebuild(covariant _CartBarDelegate old) => old.count != count;
}
