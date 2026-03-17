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
const _tertiary = Color(0xFF2C6959);
const _tertiaryContainer = Color(0xFF65A18F);


class ServiceDetailScreen extends StatefulWidget {
  final String serviceId;
  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int _selectedDate = 0;
  int _selectedSlot = 0;
  int _selectedStylist = 0;

  static const _dates = [
    _DateChip('Oct', '14', 'Mon'),
    _DateChip('Oct', '15', 'Tue'),
    _DateChip('Oct', '16', 'Wed'),
    _DateChip('Oct', '17', 'Thu'),
    _DateChip('Oct', '18', 'Fri'),
  ];

  static const _slots = [
    '09:00 AM', '11:30 AM', '02:00 PM', '04:15 PM', '06:45 PM', '08:00 PM',
  ];

  static const _stylists = [
    _StylistData('Amelia', 'Skin Specialist', true,
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBKDDBN4jDh7BZCJ5nJgvGnppLcF2uQxHYTPISx-l-ZnKpocH6lZ4ZrWEgEqzk4P2cfE7Rd1YavtFjDdp3qyH3MEXxo8zNLRskAkV2O6Ae7INiELK57wZoSEpHIgv5KK7DSyd-1WRJfelRoGrc-yF2WEo9d03TZENhl2XnJSl8Q7FgM6LtBvMouL9W6WLEB6ydltSejXZZmb2di_SljOuF5bmac9azqYzZ7aNV4NGDAlk8PTZPAhpCi9k9XsEFHzC-6jX_zFggk7kc'),
    _StylistData('Sarah', 'Master Aesthetician', false,
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBykOpa8db6HWHqJGa-suIdezTME_q997FlrAljY195wN7sWfO_4jBULX-7Zx0HvHR8FHvcKbsxfl94e3EYnUYXmRizFzS9Qd0fcl5OzvUaYeXdDB3pgMXEcZPxSdL8Jo0x_osPatH_YoWEvu9Fvj3oTmpiJ5uA1yZlhAq9GYUvsxnEzuUxtmYzeXTZcdOkVrwFJvLY78JYWHIAzcdTJMnjqMKWCkYD1dN47Hm09G1Kmj4Jz7EJh2XI26zHP8VsMAQ6AvjkO7DftCs'),
    _StylistData('Elena', 'Dermatologist', false,
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDDcPClibjFRyMpH1gDfE4CDaMfuAjyaLbdWCsdSc0HiMEBuCVzN0M_xGkg2jrpIHNzYedahalA4zhRNibtVIblzGRZiJstLvuv1jGFtGQWmpVlOs7AUcEDTeIq80-7PxPgGIyfssppYafJhQtDwgP8xe-PDXxMRodUWBZoAnJ2H1GairakWVxEiHCKzn7RPggSq_0WBbDkccrapo3m6o9xRmIgos0qqyxzaYwtj3QLC_L20yXFx9VCgb_yCSrT9YSeWLZgOXnTNhk'),
  ];

  static const _included = [
    'Deep Cleansing', 'Oxygen Steam', 'Glow Mask', 'Sculpting Massage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          // ── Hero + glassmorphic AppBar ──────────────────────────────
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: _bg.withValues(alpha: 0.85),
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Container(
                width: 38, height: 38,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.arrow_back, color: _onSurface, size: 18),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(Icons.share_outlined, color: _onSurface, size: 18),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC7CvHNZjdOYyStCAUAiFCn13ku8Ux1-arsUTPERmSYZnOgaUxDW_LU7qOzYx-gBBgctc2x6FlVjzn5afbBzNu36vhICA-SlllJRUBR_fkFjOAoqvchYik4OjxoBkEqjp3kHVhjCLhk4W812mQGdQz4-S3PYCoIrGOYiOBUj8mX1RQ9OMTyHJ59TeCbaIr4NOx7H2tm0Q06imAdXhjbdPW1fMrwYzMlCD2lkr42zOEYaqldnsmHFIzXR8zd_4z5ir1w5Awkb3urTik',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: _secondaryContainer),
                ),
                // gradient overlay
                Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [_bg, Colors.transparent]))),
              ]),
            ),
          ),

          SliverList(delegate: SliverChildListDelegate([
            // ── Info header ──────────────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: _tertiaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text('Skincare', style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 0.8)),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.star, color: _primary, size: 14),
                const SizedBox(width: 4),
                Text('4.8', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: _primary)),
                const SizedBox(width: 4),
                Text('(124 reviews)', style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVariant)),
              ]),
              const SizedBox(height: 10),
              Text('Royal Facial & Glow Treatment', style: GoogleFonts.notoSerif(fontSize: 28, color: _onSurface, height: 1.2)),
              const SizedBox(height: 14),
              Row(children: [
                const Icon(Icons.schedule_outlined, color: _primary, size: 18),
                const SizedBox(width: 6),
                Text('75 min', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(width: 20),
                const Icon(Icons.payments_outlined, color: _primary, size: 18),
                const SizedBox(width: 6),
                Text('₹1,499', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: _primary)),
              ]),
            ])),

            // ── About ─────────────────────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(20, 28, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('About This Service', style: GoogleFonts.notoSerif(fontSize: 20, color: _onSurface)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: _surfaceLow, borderRadius: BorderRadius.circular(16)),
                child: Stack(children: [
                  const Positioned(right: -8, bottom: -8, child: Opacity(opacity: 0.08, child: Icon(Icons.spa, size: 80, color: _onSurfaceVariant))),
                  Text(
                    'Experience the pinnacle of restoration with our signature atelier facial. We combine ancient herbal infusions with modern enzymatic peeling to reveal your inner radiance. This bespoke ritual is designed to soothe the soul while deeply hydrating the cellular layers of your skin.',
                    style: GoogleFonts.manrope(fontSize: 14, color: _onSurfaceVariant, height: 1.75, fontWeight: FontWeight.w300),
                  ),
                ]),
              ),
            ])),

            // ── What's Included ───────────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(20, 28, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("What's Included", style: GoogleFonts.notoSerif(fontSize: 20, color: _onSurface)),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3.4),
                itemCount: _included.length,
                itemBuilder: (_, i) {
                  final even = i % 2 == 0;
                  return Container(
                    margin: EdgeInsets.only(top: even ? 0 : 14),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: even ? _secondaryContainer : _surfaceHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      const Icon(Icons.check_circle, color: _primary, size: 18),
                      const SizedBox(width: 8),
                      Flexible(child: Text(_included[i], style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600))),
                    ]),
                  );
                },
              ),
            ])),

            // ── Select Stylist ────────────────────────────────────────
            Padding(padding: const EdgeInsets.only(top: 28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Select Stylist', style: GoogleFonts.notoSerif(fontSize: 20, color: _onSurface)),
                Text('View All', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: _primary)),
              ])),
              const SizedBox(height: 16),
              SizedBox(height: 120, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 20),
                itemCount: _stylists.length,
                itemBuilder: (_, i) {
                  final s = _stylists[i];
                  final selected = _selectedStylist == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedStylist = i),
                    child: Opacity(
                      opacity: i == 2 ? 0.55 : 1.0,
                      child: SizedBox(width: 80, child: Column(children: [
                        Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: selected ? _primaryContainer : Colors.transparent, width: 3),
                            color: _surfaceLow,
                          ),
                          child: ClipOval(child: Image.network(s.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: _secondaryContainer))),
                        ),
                        if (s.isTop) ...[
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(color: _tertiary, borderRadius: BorderRadius.circular(999)),
                            child: Text('TOP', style: GoogleFonts.manrope(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                        ] else const SizedBox(height: 6),
                        Text(s.name, style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: _onSurface), textAlign: TextAlign.center),
                        Text(s.role, style: GoogleFonts.manrope(fontSize: 9, color: _onSurfaceVariant), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ])),
                    ),
                  );
                },
              )),
            ])),

            // ── Date & Time ───────────────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(20, 28, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Choose Date & Time', style: GoogleFonts.notoSerif(fontSize: 20, color: _onSurface)),
              const SizedBox(height: 16),
              // Date row
              SizedBox(height: 80, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: _dates.length,
                itemBuilder: (_, i) {
                  final d = _dates[i];
                  final sel = _selectedDate == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDate = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 58, height: 80,
                      decoration: BoxDecoration(
                        color: sel ? _primaryContainer : _surfaceHigh,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: sel ? [BoxShadow(color: _primaryContainer.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))] : null,
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(d.month, style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, color: sel ? Colors.white70 : _onSurfaceVariant, letterSpacing: 0.5)),
                        Text(d.day, style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w700, color: sel ? Colors.white : _onSurface)),
                        Text(d.weekday, style: GoogleFonts.manrope(fontSize: 9, color: sel ? Colors.white60 : _onSurfaceVariant)),
                      ]),
                    ),
                  );
                },
              )),
              const SizedBox(height: 20),
              // Time slots
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.8),
                itemCount: _slots.length,
                itemBuilder: (_, i) {
                  final sel = _selectedSlot == i;
                  final last = i == _slots.length - 1;
                  return GestureDetector(
                    onTap: last ? null : () => setState(() => _selectedSlot = i),
                    child: Opacity(
                      opacity: last ? 0.4 : 1.0,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: sel ? const Color(0xFFFFDAD5) : _surfaceHighest,
                          border: sel ? Border.all(color: _primaryContainer, width: 1.5) : null,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(_slots[i], style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w700, color: sel ? _primary : _onSurface)),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 110),
            ])),
          ])),
        ]),

        // ── Sticky "Book Now" bar ─────────────────────────────────────
        Positioned(bottom: 0, left: 0, right: 0, child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
          color: _bg.withValues(alpha: 0.88),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('TOTAL PRICE', style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: _onSurfaceVariant)),
              Text('₹1,499', style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.w700, color: _primary)),
            ]),
            const SizedBox(width: 20),
            Expanded(child: GestureDetector(
              onTap: () => context.go('/booking-confirmation'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 17),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_primary, _primaryContainer]),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [BoxShadow(color: _primaryContainer.withValues(alpha: 0.30), blurRadius: 18, offset: const Offset(0, 6))],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Book Now', style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.calendar_month, color: Colors.white, size: 18),
                ]),
              ),
            )),
          ]),
        )))),
      ]),
    );
  }
}

class _DateChip {
  final String month, day, weekday;
  const _DateChip(this.month, this.day, this.weekday);
}

class _StylistData {
  final String name, role, imageUrl;
  final bool isTop;
  const _StylistData(this.name, this.role, this.isTop, this.imageUrl);
}
