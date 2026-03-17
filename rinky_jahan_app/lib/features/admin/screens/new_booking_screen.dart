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
const _surfaceHigh = Color(0xFFEDE7DE);
const _surfaceHighest = Color(0xFFE7E2D9);
const _outlineVariant = Color(0xFFD7C2BE);

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});
  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  int _selService = 0;
  int _selStylist = 0;
  int _selTime = 0;

  static const _services = [
    _Svc('Bridal Makeup', 'Full luxury aesthetic experience', '\$250'),
    _Svc('Royal Facial', '90-minute organic treatment', '\$120'),
    _Svc('Hair Styling', 'Signature wash and blowout', '\$85'),
  ];
  static const _stylists = [
    _Stylist('Rinky', 'https://lh3.googleusercontent.com/aida-public/AB6AXuD9Fy7RX-Cvp2DDggFVFveqSjtUexpYH9Ecdrq0mNpNBiuc-lt1zr0rdel2NdElzdVT9C9sDEum4ldEQmjUWKRuBnm1lWxQd1xoeus03J7BIICj7Gif0r71oT9fLnk9ZNoNsEjCY42vDylEcmbALMr5wZ9RXf-9_RjKeMcJC3t37ZPeTUq8_a1RoYpGhQmTVOjPo5upK6F-ue3RZQ2-iUi0JBaVkLNPwT69ciH3zaiS1kxEkPzwczgKj9NVoyvIDQBLKyYuEIZ93Ow', false),
    _Stylist('Ayesha', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCyI1Bgw0mN7A6eTYqD2CRSVBd4cR0HcLr_DwG7lRXwDVhGdzKHJWJQEOhrH1d2uzo8ryUGJ_m34q7Sff-4bBVXsPIBf24tXiPANbs1_ELuJjRXMNaulvMsV7iGh6RMHMpHKz77EVfDsvtUwJ0I6b8JuD7b_JpL23OaQ_ZhBNcr4EtwbnoMB5sUFkP-wMlfph__auL0PK5uxB3jdrel9Qs3hRhuMAO83NLcZvZW9lc3ss-32enu9HMqwyAMI58mY3Btla3h9N2JhAE', true),
    _Stylist('Mehak', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAKTcmioF6X2vgS2IRIhQCMDF_i-AAabY9Ct0SCDG4T5eHHRJxdcMLDW19a9raUnugw_K3zlglSlaPNPLPNGF1g0_DVBclAUV-pFlzIEcJ9OHqOkx4XucWpJcyeXoRhMytbVeTYwta_aBlr6rvdX3yx39P6rzk3lkGrPniApErQ4kbfM7IiqZRbGNy8jroYqM0QV3fD6o_hOmX_GbD91dOBqbEA7Mu0VLEjUK40EeF7dahe1rmIV4NvqhWz6zRbWRNs5mByHXjLb6U', true),
    _Stylist('Any Stylist', '', true, isAny: true),
  ];
  static const _times = ['10:00 AM', '11:30 AM', '01:00 PM', '02:30 PM', '04:00 PM', '05:30 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          // Header
          SliverPersistentHeader(pinned: true, delegate: _AdminCreateHeaderDelegate(onBack: () => Navigator.of(context).maybePop())),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // ── Client Selection ────────────────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('CLIENT SELECTION', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: _onSurfaceVariant)),
                Text('+ Add New Customer', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: _primary)),
              ]),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: _surfaceHighest, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find Existing Customer',
                    hintStyle: GoogleFonts.manrope(fontSize: 14, color: _onSurfaceVariant.withValues(alpha: 0.6)),
                    prefixIcon: const Icon(Icons.search, color: _onSurfaceVariant),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ── Select Service ──────────────────────────────────────
              Text('Select Service', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 16),
              ...List.generate(_services.length, (i) {
                final s = _services[i];
                final sel = _selService == i;
                return GestureDetector(
                  onTap: () => setState(() => _selService = i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _surfaceLow, borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: sel ? _primary.withValues(alpha: 0.8) : Colors.transparent),
                    ),
                    child: Row(children: [
                      Icon(sel ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: sel ? _primary : _outlineVariant, size: 20),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(s.title, style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: _onSurface)),
                        Text(s.sub, style: GoogleFonts.manrope(fontSize: 12, color: _onSurfaceVariant)),
                      ])),
                      Text(s.price, style: GoogleFonts.notoSerif(fontSize: 16, color: _primary)),
                    ]),
                  ),
                );
              }),
              const SizedBox(height: 24),

              // ── Choose Stylist ──────────────────────────────────────
              Text('Choose Stylist', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 16),
              SizedBox(height: 100, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: _stylists.length,
                itemBuilder: (_, i) {
                  final s = _stylists[i];
                  final sel = _selStylist == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selStylist = i),
                    child: Opacity(
                      opacity: sel ? 1.0 : (s.dim ? 0.6 : 1.0),
                      child: Column(children: [
                        Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: sel ? _primary : Colors.transparent, width: 2)),
                          padding: const EdgeInsets.all(2),
                          child: ClipOval(child: s.isAny
                              ? Container(color: _surfaceHighest, child: const Icon(Icons.people, color: _onSurfaceVariant))
                              : ColorFiltered(
                                colorFilter: ColorFilter.mode(sel ? Colors.transparent : Colors.grey, BlendMode.saturation),
                                child: Image.network(s.url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: _secondaryContainer)),
                              )
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(s.name, style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: _onSurface)),
                      ]),
                    ),
                  );
                },
              )),
              const SizedBox(height: 24),

              // ── Schedule ────────────────────────────────────────────
              Text('Schedule', style: GoogleFonts.notoSerif(fontSize: 22, color: _onSurface)),
              const SizedBox(height: 16),
              Text('PICK DATE', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: _onSurfaceVariant)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(color: _surfaceHighest, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '24 Oct 2024', // mocked
                    hintStyle: GoogleFonts.manrope(fontSize: 14, color: _onSurface),
                    prefixIcon: const Icon(Icons.calendar_today, color: _onSurfaceVariant, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('TIME SLOT', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: _onSurfaceVariant)),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5),
                itemCount: _times.length,
                itemBuilder: (_, i) {
                  final sel = _selTime == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selTime = i),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: sel ? _primary : _surfaceHigh, borderRadius: BorderRadius.circular(10), boxShadow: sel ? [BoxShadow(color: _primary.withValues(alpha: 0.2), blurRadius: 8)] : null),
                      child: Text(_times[i], style: GoogleFonts.manrope(fontSize: 12, fontWeight: sel ? FontWeight.w700 : FontWeight.w500, color: sel ? Colors.white : _onSurface)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // ── Notes ───────────────────────────────────────────────
              Text('SPECIAL NOTES', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: _onSurfaceVariant)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(color: _surfaceHighest, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Mention skin sensitivities or special requests...',
                    hintStyle: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVariant.withValues(alpha: 0.6)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ── Summary ─────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: _secondaryContainer, borderRadius: BorderRadius.circular(16)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('TOTAL AMOUNT', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: const Color(0xFF75605B))),
                    Text(_services[_selService].price, style: GoogleFonts.notoSerif(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF4F201A))),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Includes service tax', style: GoogleFonts.manrope(fontSize: 11, color: const Color(0xFF75605B))),
                    const SizedBox(height: 6),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: _primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)), child: Text('New Booking', style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w800, color: _primary))),
                  ]),
                ]),
              ),
            ])),
          ),
        ]),

        // ── Sticky Actions Footer ─────────────────────────────────────
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
            color: _bg.withValues(alpha: 0.85),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: GestureDetector(
              onTap: () => context.go('/admin/bookings'),
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_primary, _primaryContainer]),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [BoxShadow(color: _primary.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Confirm Booking', style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                ]),
              ),
            ),
          ))),
        ),
      ]),
    );
  }
}

class _Svc { final String title, sub, price; const _Svc(this.title, this.sub, this.price); }
class _Stylist { final String name, url; final bool dim, isAny; const _Stylist(this.name, this.url, this.dim, {this.isAny = false}); }

class _AdminCreateHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onBack;
  _AdminCreateHeaderDelegate({required this.onBack});
  @override double get minExtent => 64;
  @override double get maxExtent => 64;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox.expand(child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
        color: _bg.withValues(alpha: 0.85),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: _onSurface), onPressed: onBack),
          Expanded(child: Text('New Booking', style: GoogleFonts.notoSerif(fontSize: 19, fontWeight: FontWeight.w700, color: _onSurface))),
          IconButton(icon: const Icon(Icons.more_vert, color: _onSurface), onPressed: () {}),
        ]),
      ))));
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => false;
}
