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
const _outlineVariant = Color(0xFFD7C2BE);
const _tertiary = Color(0xFF2C6959);
const _error = Color(0xFFBA1A1A);

enum _BookingStatus { confirmed, inProgress, completed, noShow }

class ManageBookingsScreen extends StatefulWidget {
  const ManageBookingsScreen({super.key});
  @override
  State<ManageBookingsScreen> createState() => _ManageBookingsScreenState();
}

class _ManageBookingsScreenState extends State<ManageBookingsScreen> {
  int _selectedFilter = 0;

  static const _filters = ['All', 'Confirmed', 'Pending', 'Completed'];
  static const _dates = [
    _DateInfo('Mon', '23', false),
    _DateInfo('Tue', '24', true),
    _DateInfo('Wed', '25', false),
    _DateInfo('Thu', '26', false),
    _DateInfo('Fri', '27', false),
    _DateInfo('Sat', '28', false),
  ];

  static const _bookings = [
    _BookingData('10:30 AM', '60 Mins', 'Ananya S.', 'Bridal Makeup', 'Rinky Jahan', _BookingStatus.confirmed),
    _BookingData('12:00 PM', '45 Mins', 'Priya Sharma', 'Party Glow', 'Mehak', _BookingStatus.inProgress),
    _BookingData('09:00 AM', '30 Mins', 'Tanya Malik', 'Hair Spa', 'Rinky Jahan', _BookingStatus.completed),
    _BookingData('02:30 PM', '120 Mins', 'Zoya K.', 'Full Ensemble', 'Rinky Jahan', _BookingStatus.noShow),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          // ── Header ──────────────────────────────────────────────
          SliverPersistentHeader(pinned: true, delegate: _AdminHeaderDelegate(onBack: () => Navigator.of(context).maybePop())),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // ── Date Picker ───────────────────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('October 2023', style: GoogleFonts.notoSerif(fontSize: 18, fontWeight: FontWeight.w700, color: _onSurface)),
                const Icon(Icons.calendar_today, color: _primary, size: 20),
              ]),
              const SizedBox(height: 16),
              SizedBox(height: 96, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _dates.length,
                itemBuilder: (_, i) {
                  final d = _dates[i];
                  return Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: d.isActive ? _primary : _surfaceLow,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: d.isActive ? [BoxShadow(color: _primary.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))] : null,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(d.day, style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: d.isActive ? Colors.white.withValues(alpha: 0.8) : _onSurfaceVariant.withValues(alpha: 0.6))),
                      Text(d.date, style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.w700, color: d.isActive ? Colors.white : _onSurface)),
                    ]),
                  );
                },
              )),
              const SizedBox(height: 28),

              // ── Filters ───────────────────────────────────────────
              SizedBox(height: 36, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final sel = _selectedFilter == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: sel ? _primary : _surfaceHighest, borderRadius: BorderRadius.circular(999)),
                      child: Text(_filters[i], style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : _onSurface)),
                    ),
                  );
                },
              )),
              const SizedBox(height: 24),

              // ── Bookings List ─────────────────────────────────────
              ..._bookings.map((b) => _buildBookingCard(b)),
            ])),
          ),
        ]),

        // ── FAB ───────────────────────────────────────────────────────
        Positioned(
          right: 24, bottom: 104,
          child: FloatingActionButton(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            elevation: 8,
            onPressed: () => context.push('/admin/new-booking'),
            child: const Icon(Icons.add),
          ),
        ),

        // ── Admin Bottom Nav ──────────────────────────────────────────
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
            height: 80,
            decoration: BoxDecoration(color: _bg.withValues(alpha: 0.85), border: Border(top: BorderSide(color: _outlineVariant.withValues(alpha: 0.2)))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _NavIcon(Icons.dashboard_outlined, 'Dashboard', false),
              _NavIcon(Icons.event, 'Bookings', true),
              _NavIcon(Icons.people_outline, 'Clients', false),
              _NavIcon(Icons.settings_outlined, 'Settings', false),
            ]),
          ))),
        ),
      ]),
    );
  }

  Widget _buildBookingCard(_BookingData b) {
    Color cardBg = _surfaceLow;
    Color titleColor = _onSurface;
    double opacity = 1.0;
    Border? border;

    if (b.status == _BookingStatus.confirmed) {
      cardBg = _secondaryContainer;
    } else if (b.status == _BookingStatus.completed) {
      opacity = 0.6;
    } else if (b.status == _BookingStatus.noShow) {
      border = Border.all(color: _error.withValues(alpha: 0.2));
    }

    return Opacity(
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: border),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Time col
          Container(
            width: 80,
            padding: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(border: Border(right: BorderSide(color: _outlineVariant.withValues(alpha: 0.4)))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(b.time, style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700, color: b.status == _BookingStatus.confirmed ? _primary : _onSurface)),
              const SizedBox(height: 2),
              Text(b.duration, style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: _onSurfaceVariant)),
            ]),
          ),
          const SizedBox(width: 16),
          // Info col
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(b.name, style: GoogleFonts.notoSerif(fontSize: 18, fontWeight: FontWeight.w700, color: titleColor)),
              const SizedBox(width: 8),
              _Badge(b.service, b.status),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.content_cut, size: 13, color: _onSurfaceVariant),
              const SizedBox(width: 4),
              Text('Stylist: ${b.stylist}', style: GoogleFonts.manrope(fontSize: 12, color: _onSurfaceVariant)),
            ]),
          ])),
          // Actions col
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Row(children: [
              _CircleBtn(Icons.edit_outlined),
              SizedBox(width: 8),
              _CircleBtn(Icons.call_outlined),
            ]),
            const SizedBox(height: 12),
            _StatusBtn(b.status),
          ]),
        ]),
      ),
    );
  }
}

class _StatusBtn extends StatelessWidget {
  final _BookingStatus status;
  const _StatusBtn(this.status);

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    String label;
    IconData? icon;

    switch (status) {
      case _BookingStatus.confirmed: bg = _primary; text = Colors.white; label = 'Confirmed'; icon = Icons.expand_more; break;
      case _BookingStatus.inProgress: bg = const Color(0xFF65A18F); text = Colors.white; label = 'In Progress'; icon = Icons.expand_more; break;
      case _BookingStatus.completed: bg = _surfaceHighest; text = _onSurface; label = 'Completed'; icon = Icons.check_circle; break;
      case _BookingStatus.noShow: bg = const Color(0xFFFFDAD6); text = _error; label = 'No Show'; icon = Icons.error_outline; break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(children: [
        Text(label, style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600, color: text)),
        ...[const SizedBox(width: 4), Icon(icon, size: 14, color: status == _BookingStatus.completed ? _tertiary : text)],
      ]),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final _BookingStatus status;
  const _Badge(this.label, this.status);

  @override
  Widget build(BuildContext context) {
    Color bg, text;
    if (status == _BookingStatus.confirmed) { bg = const Color(0xFF65A18F).withValues(alpha: 0.15); text = const Color(0xFF2C6959); }
    else if (status == _BookingStatus.inProgress) { bg = _primaryContainer.withValues(alpha: 0.15); text = _primary; }
    else if (status == _BookingStatus.completed) { bg = _secondaryContainer; text = const Color(0xFF75605B); }
    else { bg = _primaryContainer.withValues(alpha: 0.15); text = _primary; }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w800, color: text, letterSpacing: -0.2)),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  const _CircleBtn(this.icon);
  @override Widget build(BuildContext context) => Container(
    width: 34, height: 34,
    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
    child: Icon(icon, size: 16, color: _primary),
  );
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _NavIcon(this.icon, this.label, this.active);

  @override Widget build(BuildContext context) => Opacity(
    opacity: active ? 1.0 : 0.6,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: active ? _primary : _onSurfaceVariant, size: 24),
      const SizedBox(height: 4),
      Text(label, style: GoogleFonts.manrope(fontSize: 9, fontWeight: active ? FontWeight.w800 : FontWeight.w600, color: active ? _primary : _onSurfaceVariant, letterSpacing: 0.5)),
    ]),
  );
}

class _DateInfo { final String day, date; final bool isActive; const _DateInfo(this.day, this.date, this.isActive); }
class _BookingData { final String time, duration, name, service, stylist; final _BookingStatus status; const _BookingData(this.time, this.duration, this.name, this.service, this.stylist, this.status); }

class _AdminHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onBack;
  _AdminHeaderDelegate({required this.onBack});
  @override double get minExtent => 64;
  @override double get maxExtent => 64;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), child: Container(
        color: _bg.withValues(alpha: 0.85),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(bottom: false, child: Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: _primary), onPressed: () => context.go('/home')),
          Expanded(child: Text('Manage Bookings', style: GoogleFonts.notoSerif(fontSize: 19, fontWeight: FontWeight.w700, color: _onSurface))),
          Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: _primaryContainer), child: Center(child: Text('RJ', style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)))),
        ])),
      )));
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => false;
}
