import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

// ── Mock data ──────────────────────────────────────────────────────────────────

class _VideoItem {
  final String title;
  final String author;
  final String duration;
  final String views;
  final String thumbnailUrl;

  const _VideoItem({
    required this.title,
    required this.author,
    required this.duration,
    required this.views,
    required this.thumbnailUrl,
  });
}

class _ProductItem {
  final String name;
  final String price;
  final String imageUrl;
  const _ProductItem({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

const _featuredVideoTitle = 'Smokey Eye Tutorial for Beginners';
const _featuredThumbnail =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuD6Lj_Wk_zWgiTP2PaakG06G3Zq_S-VcfX5MY1HzHBNi5QEAisMKxMyP4ao5WsYpq0Zd53opLqhxP627QNsDDc3_uoG4K0rLqAIAPagP18RoQOwg1o4p-77h5BtukZwYDoVlDC9jfc97wCaTeyXu-K6JF-xAK0pAW77-BPVQOHaYkECEUZWHvnGppY8mOBOJCvErU1KNRKUEOS4EhlHhph4-jwXqHr7HcjuCjyfQGNY0mseqMFBYcFBFF3LiLRkIEolvq24P4wIp3E';

const _productsUsed = [
  _ProductItem(
    name: 'Rose Glow Serum',
    price: '₹1,250',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD7HIBUJpK1o3dB0ne6ZVft5CCNdpQMk9nFRBqj1uziGhf5mqMeUaCqX2ktl9P63w_-roGhzDNHr9wsjyr6OKhWFQLyZ254P2XkO566-1Sio6EIA2fkunyd9Rg1qz-8y6uD4nl_zqeQ7Quqarnf_4na-cs8zHRZsK8IuXNraW2ejBJX1sg9-mVRfNxxMiSbUNbjUrMUIp_vY8hkFgbjx-tGpQDZS2sVIeazODEnpEBpsAl-pqy0UvEA4_nlgUrwpJ9PTIkw1kioMsk',
  ),
  _ProductItem(
    name: 'Midnight Eyeshadow Palette',
    price: '₹2,100',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuC03eTE1aGZ9BtpQ9HCuG_IC-NH3TRphuXHXuYqv6QR37YlAqcwezbE0zGMM5Dpu1fgnzm0Tj8jabQqF-6wM_FxBkFQh2YsPY8LK3G04CPAlLM3EKjb-gdD1pp96G2u8YheAGDtrMBRkJKsMV8SkkWwvkOHY3GN0FHN2a2GVAiVb2K3VzeVfFBd9_XANjT3GJkN9PynVZ2N3TQBpgGr7A3PM2OM-cFah7l-zRuEhe_Rp2XUByJzyAjtlmC3AOK_DjzPcHkex0LKthA',
  ),
  _ProductItem(
    name: 'Pro Blending Brush 02',
    price: '₹850',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAq8Qg_Sn0Fw48qUWZI7E7UEMd3J3mf5OKskC-RXwdrDf72ngMEfIvm9ds6vD3qkl6gzyzCQoIPs0F-rQs-d-qrJDV1TIQgsKKb1V6ZjrWOtE8brqX987JNntbTK49nsfpsI4CN8vz1iNFjX9Hu5v27ik1kmnfdU9kg3vhJTuWAzeAHjAff_lfDAI9Q-DttJZeYUAi7fgO4PjXLIUbksu95YmfP8nHvigx7l6Mwt_Latu7qm8Li9-AyG3qNJxZ0Q6RJFYubSRsRLUg',
  ),
];

const _upNext = [
  _VideoItem(
    title: 'Contouring 101: Define Your Features',
    author: 'Rinky Jahan',
    duration: '12:00',
    views: '152k views',
    thumbnailUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAviUjyB9EygWkMko1YT4EFTjGdlETo3v9s0x6wfikUpv-xRBtb3HfnY6EwtAWhZHp_f0MLO7tUdWH9jrgnzDmZu2MtCzRiD0zIssW0_bhCRrBPrKjo23XKEPPIXf8iB0iQ45xlkdFzUgV5ETnKNmfIupCCeNzZG5WYp9P2UM2Y29uRvNqnVdezOUon0JI8cxRkSwgh8M8zhgf89Sido0a93B05dDwT4F0jjTIpWONy7snfv-s1xJtQVXCrKYi4Tp2a_xTDKGfXGAI',
  ),
  _VideoItem(
    title: 'Bridal Glow Routine: Long Lasting Base',
    author: 'Rinky Jahan',
    duration: '08:45',
    views: '89k views',
    thumbnailUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCZ4043hv197zTDlkfIphJK2DgZ5b87WhTBuMQVsfRqbw2_97EWavPBUeIxexffssVZyMO-tLw67_BH3D5svwvRD2-njmPv30svQdyDHQHtt0sq7SkExkKfgGT_u8tzGbIoL_fn37c_kFHVdgDf6BwMCSZzWYD1VCNli1mESy5mV4F7PFbe3jUHniLIdxUF6yfiVvdSR4TtyJNIXSwNyqkeXqN4-xTpXNlPKv6kr0nvYun4T-6a6sviKP3WWGRK5M7_21x7ksX5r0',
  ),
  _VideoItem(
    title: 'The Perfect Red Lip: Precision Tips',
    author: 'Rinky Jahan',
    duration: '05:20',
    views: '210k views',
    thumbnailUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA_9jO2WzVxVvLXQE7wmXHD4K73NHpvABNWjIlK-nKX0APvn15o4w9qQiRzIXHq5ozHeVYFQw0FY6r1qoQ4emXIXdUeQWJxe4-lWobTFrWLWI3bNxYInT-mr5sJQiavz3SmadVkIpVvISa0hag6QKB10aYUWP3FFvdWxQUXwWd1dE8mzgQ7bgoF-reMHW3iTQNeHfaLy4Z30n9lv2937k34YZywSBhLbit9ANjO5b9umUzvi1YswiCbABUU03ugyQyvUnD2JJDsikA',
  ),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class _LearnScreenState extends ConsumerState<LearnScreen> {
  bool _descExpanded = false;
  bool _liked = false;
  bool _saved = false;

  // Brand colours
  static const _primary = Color(0xFF894E46);
  static const _primaryContainer = Color(0xFFC9847A);
  static const _bg = Color(0xFFFFF9EF);
  static const _secondary = Color(0xFF6E5A55);
  static const _onSurface = Color(0xFF1D1B16);
  static const _onSurfaceVariant = Color(0xFF524341);
  static const _surfaceLow = Color(0xFFF9F3EA);
  static const _secondaryContainer = Color(0xFFF9DCD6);
  static const _surfaceHigh = Color(0xFFEDE7DE);
  static const _outlineVariant = Color(0xFFD7C2BE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Glassmorphic sticky header ──────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _LearnAppBarDelegate(
              onSurface: _onSurface,
              primary: _primary,
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              // ── Featured video thumbnail ────────────────────────────────
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Thumbnail
                    Image.network(
                      _featuredThumbnail,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.20),
                      colorBlendMode: BlendMode.darken,
                      errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFF32302A)),
                    ),
                    // Gradient scrim
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x99000000)],
                          stops: [0.4, 1.0],
                        ),
                      ),
                    ),
                    // Play button + seek bar
                    Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.white.withOpacity(0.20),
                                  child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 36),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Seek bar + controls
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.circular(2),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 1 / 3,
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: _primaryContainer,
                                        borderRadius:
                                            BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.volume_up,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 10),
                                  Text('04:12 / 12:45',
                                      style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          color: Colors.white)),
                                  const Spacer(),
                                  const Icon(Icons.fullscreen,
                                      color: Colors.white, size: 18),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Video info ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TUTORIAL SERIES',
                      style: GoogleFonts.manrope(
                          fontSize: 10,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w700,
                          color: _primary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _featuredVideoTitle,
                      style: GoogleFonts.notoSerif(
                          fontSize: 26, color: _onSurface, height: 1.25),
                    ),
                    const SizedBox(height: 16),

                    // Instructor row
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _surfaceLow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _primaryContainer, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuB-_h9dyEB2fv63Hey5p2dKa2LDupDLw2B2PdQmAxuX9WklVv4RCWbliTqTWdTN75V3KUh6JvHwXSfEocMya9uylqtW5weNid4JbpN4cR1Qc9UMLNyizfhllQ-J2Qbrf0AimQD5jQnQuGE3_62HVTrPxLYMr_wxVyMTdHbKNpuLJOfwepbnb5JDDBBwPsML-IeYDgGoiVmi4DQiVwc2rA2Opw5e-1qPe-mDj-vbFRAMz2jijXJaLuJbS-apEvpXuIxu5oWLtBDcc1Y',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: _primaryContainer,
                                  child: const Icon(Icons.person,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rinky Jahan',
                                    style: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: _onSurface)),
                                Text('Master Educator',
                                    style: GoogleFonts.manrope(
                                        fontSize: 11,
                                        color: _onSurfaceVariant)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: _primary, width: 1.5),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('Follow',
                                style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: _primary)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Engagement row
                    Row(
                      children: [
                        _EngagementBtn(
                          icon: _liked
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          label: '2.4k',
                          primary: _primary,
                          onSurface: _onSurface,
                          onSurfaceVariant: _onSurfaceVariant,
                          active: _liked,
                          onTap: () =>
                              setState(() => _liked = !_liked),
                        ),
                        const SizedBox(width: 28),
                        _EngagementBtn(
                          icon: Icons.share_outlined,
                          label: 'Share',
                          primary: _primary,
                          onSurface: _onSurface,
                          onSurfaceVariant: _onSurfaceVariant,
                          active: false,
                          onTap: () {},
                        ),
                        const SizedBox(width: 28),
                        _EngagementBtn(
                          icon: _saved
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          label: 'Save',
                          primary: _primary,
                          onSurface: _onSurface,
                          onSurfaceVariant: _onSurfaceVariant,
                          active: _saved,
                          onTap: () =>
                              setState(() => _saved = !_saved),
                        ),
                      ],
                    ),
                    Divider(
                        color: _outlineVariant.withOpacity(0.30),
                        height: 28),

                    // Description expandable
                    GestureDetector(
                      onTap: () => setState(
                          () => _descExpanded = !_descExpanded),
                      child: Row(
                        children: [
                          Text('Video Description',
                              style: GoogleFonts.notoSerif(
                                  fontSize: 17, color: _onSurface)),
                          const Spacer(),
                          AnimatedRotation(
                            turns: _descExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.expand_more,
                                color: _onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Master the classic smokey eye with this step-by-step tutorial. Rinky breaks down the blending techniques, color selection, and essential tools you need to create a stunning, professional look that lasts all night.',
                          style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: _onSurfaceVariant,
                              height: 1.7),
                        ),
                      ),
                      crossFadeState: _descExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Products used ───────────────────────────────────────────
              Container(
                color: _surfaceLow,
                padding:
                    const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Products Used in This Video',
                          style: GoogleFonts.notoSerif(
                              fontSize: 22, color: _onSurface)),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _productsUsed.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 14),
                        itemBuilder: (_, i) {
                          final p = _productsUsed[i];
                          return _ProductCard(
                            product: p,
                            primary: _primary,
                            primaryContainer: _primaryContainer,
                            secondaryContainer: _secondaryContainer,
                            onSurface: _onSurface,
                            secondary: _secondary,
                            onAdd: () => context.go('/shop'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ── Up Next ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 80),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Up Next',
                            style: GoogleFonts.notoSerif(
                                fontSize: 22, color: _onSurface)),
                        Text('Auto-play On',
                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: _primary,
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ..._upNext.map((v) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _UpNextCard(
                            video: v,
                            onSurface: _onSurface,
                            onSurfaceVariant: _onSurfaceVariant,
                            primary: _primary,
                            surfaceHigh: _surfaceHigh,
                          ),
                        )),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ── App bar delegate ──────────────────────────────────────────────────────────

class _LearnAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color onSurface;
  final Color primary;

  _LearnAppBarDelegate(
      {required this.onSurface, required this.primary});

  @override
  double get minExtent => 62;
  @override
  double get maxExtent => 62;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: const Color(0xFFFFF9EF).withOpacity(0.82),
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: onSurface),
                  onPressed: () {},
                ),
                Text(
                  'Learn',
                  style: GoogleFonts.notoSerif(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: onSurface),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.more_vert, color: onSurface),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _LearnAppBarDelegate old) => false;
}

// ── Engagement button ─────────────────────────────────────────────────────────

class _EngagementBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primary;
  final Color onSurface;
  final Color onSurfaceVariant;
  final bool active;
  final VoidCallback onTap;

  const _EngagementBtn({
    required this.icon,
    required this.label,
    required this.primary,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon,
              color: active ? primary : onSurface, size: 22),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.manrope(
                  fontSize: 13,
                  color: active ? primary : onSurfaceVariant)),
        ],
      ),
    );
  }
}

// ── Product card ──────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  final _ProductItem product;
  final Color primary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color onSurface;
  final Color secondary;
  final VoidCallback onAdd;

  const _ProductCard({
    required this.product,
    required this.primary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.onSurface,
    required this.secondary,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.white,
                  child: Icon(Icons.spa, color: primaryContainer),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: onSurface),
          ),
          Text(product.price,
              style: GoogleFonts.manrope(
                  fontSize: 11, color: secondary)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primary, primaryContainer]),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_shopping_cart,
                      color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text('Add',
                      style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Up-next card ──────────────────────────────────────────────────────────────

class _UpNextCard extends StatelessWidget {
  final _VideoItem video;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color primary;
  final Color surfaceHigh;

  const _UpNextCard({
    required this.video,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.primary,
    required this.surfaceHigh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 140,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    video.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: surfaceHigh),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.70),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duration,
                        style: GoogleFonts.manrope(
                            fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: onSurface,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(video.author,
                      style: GoogleFonts.manrope(
                          fontSize: 11, color: onSurfaceVariant)),
                  const SizedBox(width: 6),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD7C2BE),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(video.views,
                      style: GoogleFonts.manrope(
                          fontSize: 11, color: onSurfaceVariant)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
