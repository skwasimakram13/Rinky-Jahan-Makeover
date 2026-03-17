import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Data models ───────────────────────────────────────────────────────────────

class ServiceCategory {
  final String label;
  final String icon; // Material icon name (mapped to IconData in the widget)
  const ServiceCategory({required this.label, required this.icon});
}

class ProductItem {
  final String name;
  final String subtitle;
  final String price;
  final String imageUrl;
  final bool isFavourited;
  const ProductItem({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.isFavourited = false,
  });
}

class TutorialItem {
  final String title;
  final String duration;
  final String views;
  final String thumbnailUrl;
  const TutorialItem({
    required this.title,
    required this.duration,
    required this.views,
    required this.thumbnailUrl,
  });
}

class HomeState {
  final String userName;
  final int loyaltyPoints;
  final int cartCount;
  final String searchQuery;
  final List<ServiceCategory> categories;
  final List<ProductItem> products;
  final List<TutorialItem> tutorials;

  const HomeState({
    this.userName = 'Priya',
    this.loyaltyPoints = 1240,
    this.cartCount = 2,
    this.searchQuery = '',
    required this.categories,
    required this.products,
    required this.tutorials,
  });

  HomeState copyWith({String? searchQuery, int? cartCount}) => HomeState(
        userName: userName,
        loyaltyPoints: loyaltyPoints,
        cartCount: cartCount ?? this.cartCount,
        searchQuery: searchQuery ?? this.searchQuery,
        categories: categories,
        products: products,
        tutorials: tutorials,
      );
}

// ── Mock data ─────────────────────────────────────────────────────────────────

const _mockCategories = [
  ServiceCategory(label: 'Spa', icon: 'spa'),
  ServiceCategory(label: 'Makeup', icon: 'face_retouching_natural'),
  ServiceCategory(label: 'Hair', icon: 'content_cut'),
  ServiceCategory(label: 'Nails', icon: 'brush'),
  ServiceCategory(label: 'Facials', icon: 'self_improvement'),
];

const _mockProducts = [
  ProductItem(
    name: 'Radiance Glow Serum',
    subtitle: 'Pure Vitamin C & Hyaluronic',
    price: '₹3,499',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD2VGuiYC1ko-KnCsUel5gVVP90t8U3oDJy7F_nl_v107u-1iBQLHmO6IdQcmpAACXzskrqj5jYG0qRwZ4a9UNtnlHb_ed4IX83Jped3vRZoDqEZTxh-4UUbPZzn0CoUmLAtHgRspbEa6r70IMK8WlrhXuqqCyoe84W3BFqOkvdozh4M0xrpzOCkRbqkohQkSWzwXFHTqdS32lgFpL1wk9EhMoe0FA_Fkb1NLn9iCzFpzcGvuEIZHRj7mdy8R5vlEW-aU1JBaz6UQ8',
  ),
  ProductItem(
    name: 'Rose Quartz Mist',
    subtitle: 'Soothing Botanicals',
    price: '₹2,299',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBz5nlm3CgR6QkOefmM-7b1XW5TX2iS-h5O_g4XqGFp8mb-Nj5n8vxr-SVFiRQLac4X0H3G9aJ30-_J8b-RQiSm9MJ_7NdrasXAMj7X1ggnyaJMEHARJtV3xbzbgTZ2hw3-BwtCvoqi9wrJLjp_pQp95PoRNdJF7MJ-egn3ZxE2T-Z4cEZWUMh0iWBKXwT4916KBB5mFaPY_RG5iEsze_YC5CF2Pp4Z8miCRejqSCIfK7kcHlvlD3ffH4AHjGVBJJaLM_mO2SsOCio',
  ),
  ProductItem(
    name: 'Volcanic Clay Mask',
    subtitle: 'Deep Pore Detox',
    price: '₹2,899',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAdBi5zCvn3S92BcuIx-2Zr9nj4xXpUkyQTdXABa0nBb6BzgAc86vJyJE3iLFHCy0DOm7Elj7QFs2eUTO623HqiJqT7aFxQMAA5XNowwzEJn3Irt_HsHinwTV99agrTtBapRMseSo65gS4SyujkNNcMx1VYyQPv45YcV9ibedC31I6ZcIyblLLbOf2TBR7JLVWduKlBVKTIrVHwlQzuf_AsSdOJHPW4320UMAeKU1LmEPUbPrOwTUf-KyIggeJ9yR9IEOL83-UyWP8',
  ),
];

const _mockTutorials = [
  TutorialItem(
    title: 'Perfect Evening Glow',
    duration: '12 min',
    views: '45k views',
    thumbnailUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuABOjvJR9mZisukWY0u74IMLgdeKrWch3CckZX4F4fdwYetGGGrVwykXuuyhmIPwoP7kaYxDQOnwsZiar9nLxHLIASZxP5pEaBYGJEy4hlI2eFzlLFikJXaRvjyF3Ae0GgPur9T1n-rTpouqYnYiui5fFVUfutcmMzTMpbSvEbFEkW8eNUg2K3i19uyujWgfSxNYtIGOG7khDGxaf10Z2ive8Bp9_SRUVWKNsx3YlZEYMebzKlAsrBrayDE0PafGNDTRUKq0iB8S8Q',
  ),
  TutorialItem(
    title: 'Effortless Beach Waves',
    duration: '08 min',
    views: '22k views',
    thumbnailUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAbv2GokYPHdNUBvYV0UOc3SoLv5SJqKvTlHaA40nqu9J3kJYb2RK6SlB1Lmnk3D0T3YJFzdsGs_65C6nI3Ire9FG9fFD6T5eAlSwezFHCLlzlrh7EIElyIR-90xT4EL91-t8jvqXZBr3ml6ahlsYCO6RgqVIusHDj1QzWo6w1HamG3f7RWl36BdpbOLKC4MWOuVZPU3AuJ-mgBuXcjozoJvLZCG2hm2vgIFMpOeKdVl8lbmubOWfn7unNKM4QjWZDJN2Ep1eLYitA',
  ),
];

// ── Provider ──────────────────────────────────────────────────────────────────

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() => const HomeState(
        categories: _mockCategories,
        products: _mockProducts,
        tutorials: _mockTutorials,
      );

  void search(String q) => state = state.copyWith(searchQuery: q);
  void addToCart() => state = state.copyWith(cartCount: state.cartCount + 1);
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
