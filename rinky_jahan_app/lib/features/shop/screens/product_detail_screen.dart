import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Colours ──────────────────────────────────────────────────────────────────
const _primary = Color(0xFF894E46);
const _primaryContainer = Color(0xFFC9847A);
const _bg = Color(0xFFFFF9EF);
const _onSurface = Color(0xFF1D1B16);
const _onSurfaceVariant = Color(0xFF524341);
const _secondaryContainer = Color(0xFFF9DCD6);
const _surfaceLow = Color(0xFFF9F3EA);
const _outlineVariant = Color(0xFFD7C2BE);

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedVariant = '30ml';
  bool _wishlisted = false;


  static const _variants = ['30ml', '50ml', '100ml'];

  static const _reviewData = [
    _Review(
      stars: 5,
      text: '"My skin has never looked this radiant. The glow is real and the texture of this serum is like liquid silk."',
      name: 'Elena M.',
    ),
    _Review(
      stars: 5,
      text: '"The scent is heavenly—like walking through a rose garden at dawn. Essential part of my morning."',
      name: 'Sophie L.',
    ),
    _Review(
      stars: 4,
      text: '"Lightweight but incredibly moisturizing. I\'ve noticed a visible difference in my hyperpigmentation."',
      name: 'Marcus K.',
    ),
  ];

  static const _related = [
    _RelatedProduct('Rose Petal Cleanser', '₹2,200',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBytSx_RL_ZTdUqMc3nOh6V0xlD8-ZpZ5NQqKKxDVDnWyZ5tZ-m7hJIbgvxYlN1g36LzHom5CuyJJEADrALtMVUZKFsvXt8AEaTx1UBszgU-mjCrvamsl7hjyUKuCV-UP-Evm8aMM3s03ki49O6-A7qL2kSqEyrNBoA3SKgg1h2sMCU1kkIrSQ165PCBqQ1HGvGWTVna4juzEMF_waqN1lwX__7gOUyBclPCApsFL5BuIIftQqsv8RhkBVrar5Ca483tsIrntyCXus'),
    _RelatedProduct('Velvet Night Cream', '₹4,999',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBo9Z8RCBxxSiFEpmO5UJfjSVO3P6pE54up0Lne22lqdv7-_QKB81BJPLFKiUFFZWoVQoGuywp00y6yLz4fyZN0lKAmLeEbl76d7ChBpjPz61WMFYO4QzXB5SS59v4rL2Q9ggP6A6KXgzn-RymDTtrKnqIo2LLbTXC41utYlDixkawEqgYEhEOnBBhds-ElpZbu99QtF4luyfls_7e-Fzxqq2K4t53elpXNu05f6tc-TEMBpg-fBAxI67TbcN_KWI6FrNPd5I7W4NA'),
    _RelatedProduct('Morning Dew Mist', '₹1,999',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCsCWLeeAgAe4pr_dEOPe7x2phVqkGCwc12GOdtmJp4V8TmtXsG3FLFk3T5n1rmZSfxfROexwoj83NPkL83iLIJFUrhZ5nbd974NoiEHjtN7ezYm8T5j8qEF6asgw0DQMvZeKY_reA7r5Ifb87KS4XSbCTWNH7Jr33sQKkmWjOkUl8Fdr7ypYTni26fG5aGAhdgCgA_gHhHVjrUhqkXqVNdTycAh3HVzVdOgqMjYMUZg0NoAMTpjAyGEY_-CWlIc_vzKxtMze-BXfA'),
    _RelatedProduct('Eternal Glow Oil', '₹5,799',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBUirTWOzKdfHxF3IxmEj_S1z2FbNCmqwtd5Td9jm9JydZsP69bTA6s-_lEAx0lOwjxzdIC4V2g4fIRNaHywKAAcqH0DH3NEWuO0iIz5OZUnnd5g3boUnaV5bfKKgx_mq01m9Y6G2v_LLgKh-xmx0COEi-L4Yjwe5qPgr2e7xZkSdG69hvlTqpegaY5p0Pnw4IFfVqWGuTIZtwsRUt4UOvb80Bn-mPIKLF00KD2NCTzScevF-Ak9UBLPoeYjl8oxktEqkAM4JGv8CI'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Glassmorphic header ───────────────────────────────────
              SliverPersistentHeader(
                pinned: true,
                delegate: _PdAppBarDelegate(
                  onBack: () => Navigator.of(context).maybePop(),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  // ── Gallery (main + 2 secondary) ─────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Column(
                      children: [
                        // Main image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBRTxaOrAtvdVJK29UDjNgAOeQ4N7u6mb1P30kPf-WA6wZ-mnPHJaOFIvnq_MrgRzorfEZzoBKQhmRSEnHpmmh8e_gOOEP1DWoqpxstjiyMgus2tLr7740_MuGKdOEoV5sbUVAAs36tEiEPIal4rWkoNfp80b83hOH6WUnxIXZ95-mDEQ6DYAXqNcPJs1aUVBHygzLbLxVPGJnT0dRhaKzKJsr_1s_YaGb3hTzLPWZBNfLYjD9T9eVanRJ7M2MI2b0ccDpneHzhO44',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Container(color: _secondaryContainer),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Two thumbnails
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAoLwQpQZTz6HAYClCfugVPWpitJnG8lQm57Gl6t7KofyQDD8KZgoswOGqgnzietcJdMW8Ddpg7HW8RgRI7q7egpF-b5UAeI5nDYdEvD1aLmgJuu3h0rhG9Z2QviSFtawEIq5hHVy6agq0G_wrIRig7ZVAYKGt_AwosELdT8tYHqfjm-uUEUhFvfCGwf5I_l4m54g0N5zbDRlkgVVMqUg1ATmEO1yXOlYD3DVpFC7do-O8bQRhDWkh5tdM8GiM5HRChXHiOP2TDopQ',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(color: _surfaceLow),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD_VIiWfiReR6VpEMLVBH1teBlgEjUehIc72ZGSbd2OhE2rlSN8Z3R84ud73ZC3G10N4qU-wFRZSaXlPb4qVg-lVsDwZRF4HVFm9kjQ50Qm8C1f7T1uwwdr3w9TJFYN-RyzC2ADxKIDeXJz1D1oxAFvrwrcefVEsG9aw_emZ9YZTo2n6YRQLX6yOmelm8-hW0Su5t_rab7hU8upqmWOEUQEiyEoNjiI2hLxeTjT7aHopFUAkvdO31upAj1jVXC2CubxD6i9SFBS90U',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(color: _surfaceLow),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ── Product info ────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breadcrumb
                        Row(
                          children: [
                            Text('Skincare',
                                style: GoogleFonts.manrope(
                                    fontSize: 11,
                                    letterSpacing: 1.4,
                                    color: const Color(0xFF857370),
                                    fontWeight: FontWeight.w700)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text('/', style: GoogleFonts.manrope(fontSize: 11, color: const Color(0xFF857370))),
                            ),
                            Text('Serums',
                                style: GoogleFonts.manrope(
                                    fontSize: 11,
                                    letterSpacing: 1.4,
                                    color: const Color(0xFF857370),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Title
                        Text('Rose Glow Vitamin C Serum',
                            style: GoogleFonts.notoSerif(
                                fontSize: 28,
                                color: _onSurface,
                                height: 1.2)),
                        const SizedBox(height: 12),

                        // Price + rating
                        Row(
                          children: [
                            Text('₹4,499',
                                style: GoogleFonts.notoSerif(
                                    fontSize: 24, color: _primary)),
                            const SizedBox(width: 14),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < 4 ? Icons.star : Icons.star_border,
                                  color: _primaryContainer,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text('(128)',
                                style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: _onSurfaceVariant)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'An ultra-potent, botanical-infused serum that brightens dull skin, smooths texture, and provides a luminous, rose-tinted finish. Hand-crafted in small batches for peak potency.',
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: _onSurfaceVariant,
                              height: 1.7),
                        ),
                        const SizedBox(height: 24),

                        // Variant selector
                        Text('SELECT VOLUME',
                            style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.8,
                                color: const Color(0xFF857370))),
                        const SizedBox(height: 12),
                        Row(
                          children: _variants.map((v) {
                            final active = v == _selectedVariant;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedVariant = v),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: active
                                        ? _primaryContainer.withValues(
                                            alpha: 0.12)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: active
                                          ? _primary
                                          : _outlineVariant,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    v,
                                    style: GoogleFonts.manrope(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: active
                                          ? _primary
                                          : _onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // Feature badges
                        const Row(
                          children: [
                            Expanded(
                              child: _FeatureBadge(
                                  icon: Icons.eco_outlined,
                                  label: 'Vegan & Cruelty Free'),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _FeatureBadge(
                                  icon: Icons.water_drop_outlined,
                                  label: 'Deep Hydration'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ── Reviews ──────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 36, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Loved by the Community',
                            style: GoogleFonts.notoSerif(
                                fontSize: 22, color: _onSurface)),
                        const SizedBox(height: 20),
                        ..._reviewData.asMap().entries.map((entry) {
                          final i = entry.key;
                          final r = entry.value;
                          return Container(
                            margin: EdgeInsets.only(
                                top: i == 1 ? 16 : 0, bottom: 14),
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: _secondaryContainer,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (j) => Icon(
                                      j < r.stars
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: _primary,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(r.text,
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        height: 1.65,
                                        color: const Color(0xFF75605B))),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: _primaryContainer,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(r.name,
                                            style: GoogleFonts.manrope(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13)),
                                        Text('Verified Buyer',
                                            style: GoogleFonts.manrope(
                                                fontSize: 11,
                                                color: const Color(
                                                    0xFF6E5A55))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  // ── Related products ─────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 36, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('COMPLETE THE LOOK',
                            style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.8,
                                color: _primary)),
                        const SizedBox(height: 8),
                        Text('Recommended Ritual',
                            style: GoogleFonts.notoSerif(
                                fontSize: 22, color: _onSurface)),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: _related.length,
                          itemBuilder: (_, i) =>
                              _RelatedProductCard(product: _related[i]),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),

          // ── Sticky bottom bar ─────────────────────────────────────────
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 6, 6, 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                    color: _outlineVariant.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('TOTAL',
                          style: GoogleFonts.manrope(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                              color: const Color(0xFF857370))),
                      Text('₹4,499',
                          style: GoogleFonts.notoSerif(
                              fontSize: 18, color: _onSurface)),
                    ],
                  ),
                  const Spacer(),
                  // Wishlist
                  GestureDetector(
                    onTap: () =>
                        setState(() => _wishlisted = !_wishlisted),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _outlineVariant),
                      ),
                      child: Icon(
                        _wishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Add to bag
                  GestureDetector(
                    onTap: () => context.go('/cart'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [_primaryContainer, _primary]),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryContainer.withValues(alpha: 0.35),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        'Add to Bag',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── App bar delegate ──────────────────────────────────────────────────────────

class _PdAppBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onBack;
  _PdAppBarDelegate({required this.onBack});

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: _bg.withValues(alpha: 0.85),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: _onSurface),
                  onPressed: onBack,
                ),
                const Spacer(),
                Text('Rinky Jahan Makeover',
                    style: GoogleFonts.notoSerif(
                        fontSize: 17, color: _onSurface)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined,
                      color: _onSurfaceVariant),
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
  bool shouldRebuild(covariant _PdAppBarDelegate old) => false;
}

// ── Feature badge ─────────────────────────────────────────────────────────────

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: _outlineVariant.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: _primary, size: 20),
          const SizedBox(width: 10),
          Flexible(
            child: Text(label,
                style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}

// ── Data classes ──────────────────────────────────────────────────────────────

class _Review {
  final int stars;
  final String text;
  final String name;
  const _Review({required this.stars, required this.text, required this.name});
}

class _RelatedProduct {
  final String name;
  final String price;
  final String imageUrl;
  const _RelatedProduct(this.name, this.price, this.imageUrl);
}

class _RelatedProductCard extends StatelessWidget {
  final _RelatedProduct product;
  const _RelatedProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) =>
                  Container(color: _surfaceLow),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(product.name,
            style: GoogleFonts.notoSerif(
                fontSize: 14, color: _onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        Text(product.price,
            style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _primary)),
      ],
    );
  }
}
