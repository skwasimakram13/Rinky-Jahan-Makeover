import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Models ─────────────────────────────────────────────────────────────────────

class ShopProduct {
  final String id;
  final String name;
  final String price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviews;

  const ShopProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });
}

// ── Mock data ──────────────────────────────────────────────────────────────────

const _allProducts = [
  ShopProduct(
    id: '1',
    name: 'Luminous Elixir',
    price: '₹3,999',
    category: 'Skincare',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCZLe3Iq6gZ37mn8g019odddI6rjghOmCumdsSmAH_7Ynwfof1-FUGZoTNATel0NZv46Ed9YKfeD_BtBkOCYTNuXiQ7bt0sgNuBqF0gJFvIfKqFJ6LpbCULpFYIu5ab1zgdwudftuy5LTKF0EZo-aP2AJMj5eKT5QJ-SEw_jESQ0Z72XymyA3AoY2PbdZGg_4HqBQxj3oqHwZhYDBwYRdLXUdF5EaAW43OoY2XUQnPYtqjhS4B7jZroXfh7xKJb0WlV15fTaz-zrrs',
    rating: 4.9,
    reviews: 124,
  ),
  ShopProduct(
    id: '2',
    name: 'Velvet Sculpt',
    price: '₹5,199',
    category: 'Makeover Kits',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCc-AGc5GdjE6lb9O9BSXsAhmfbJqzTF6CEzRDfUoCR3XKSlD7Tx-qPzD1sleV7HAA90y2fRzXGFitN93Lxjgh-JCrMTjWLKHe4lgGqk-lVmN9E5Z8i8WzP-17fXWlXw01LvUiHWOdyfz8FFTUicn46VEbzJUJwScpHGM5uaZxp5XpxcZUiCcBOvH5lWeqJhlZLSi7lnrDB6U2tKqymYFDPZ3r_4aS2xWMo0GuLhINiBRksFpFzbPCeWzScxpOlX-VtU-YAIJR_bzg',
    rating: 5.0,
    reviews: 89,
  ),
  ShopProduct(
    id: '3',
    name: 'Silk Stain Palette',
    price: '₹2,899',
    category: 'Makeover Kits',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBhji68XNgupD_6lqehDc0_p88uS0x6sV9F9dh_twMCol0tCBta4R6vYdsQ2fzUBOVpADjzE1n8Yphjrw-OYPu5JFYkydmafmDaUufZWgPXTugS9oIFJj-9_yh7MBkz5bGIlTP0Bamt8XGTXe883zpwaHsjV5DFRGsPDTOow6LUQJyT2-1PfvxP59fs5pY83IihemIJ0nPJZ-wGLfAdlXzsrGdNw2F-y7xTrCiv1l3xPQfLHZongjTG4au8n0EJ6k-maZNvlHQix1U',
    rating: 4.8,
    reviews: 210,
  ),
  ShopProduct(
    id: '4',
    name: 'Dewy Mist',
    price: '₹2,399',
    category: 'Skincare',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA4JMhF7aw_2Nswe_YkP0rH8y0bLJvjLK_cBzs7Mg-W57FrIf-aI8-KJqz0OTSF_UI_tDgaw_dUKPk6uDv2QHaw2DLU5VJcUGOQytCaOGrH10LRhsqeO_1tiG2aYgOgDxe4uz_TlGmFLQJkVWIk9FNtu54XvUrBpitazWaZV0-FdQ5sMHYN-_0iWLJM-omBe_QV1JSuYhRNW8mYb2BTY8E0T4f9f28A5JwiZUfKWhtdjmYDD6oHtoXv7k65qkLE7515_UdHRvUkDJ0',
    rating: 4.7,
    reviews: 54,
  ),
  ShopProduct(
    id: '5',
    name: 'Rose Gold Elixir',
    price: '₹6,499',
    category: 'Fragrance',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD2VGuiYC1ko-KnCsUel5gVVP90t8U3oDJy7F_nl_v107u-1iBQLHmO6IdQcmpAACXzskrqj5jYG0qRwZ4a9UNtnlHb_ed4IX83Jped3vRZoDqEZTxh-4UUbPZzn0CoUmLAtHgRspbEa6r70IMK8WlrhXuqqCyoe84W3BFqOkvdozh4M0xrpzOCkRbqkohQkSWzwXFHTqdS32lgFpL1wk9EhMoe0FA_Fkb1NLn9iCzFpzcGvuEIZHRj7mdy8R5vlEW-aU1JBaz6UQ8',
    rating: 4.9,
    reviews: 76,
  ),
  ShopProduct(
    id: '6',
    name: 'Petal Soft Blush',
    price: '₹1,799',
    category: 'Makeover Kits',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBz5nlm3CgR6QkOefmM-7b1XW5TX2iS-h5O_g4XqGFp8mb-Nj5n8vxr-SVFiRQLac4X0H3G9aJ30-_J8b-RQiSm9MJ_7NdrasXAMj7X1ggnyaJMEHARJtV3xbzbgTZ2hw3-BwtCvoqi9wrJLjp_pQp95PoRNdJF7MJ-egn3ZxE2T-Z4cEZWUMh0iWBKXwT4916KBB5mFaPY_RG5iEsze_YC5CF2Pp4Z8miCRejqSCIfK7kcHlvlD3ffH4AHjGVBJJaLM_mO2SsOCio',
    rating: 4.6,
    reviews: 37,
  ),
];

const _shopCategories = [
  'All Collections',
  'Skincare',
  'Makeover Kits',
  'Fragrance'
];

// ── State ──────────────────────────────────────────────────────────────────────

class ShopState {
  final String selectedCategory;
  final String searchQuery;
  final List<ShopProduct> allProducts;
  final Set<String> cartIds;

  const ShopState({
    this.selectedCategory = 'All Collections',
    this.searchQuery = '',
    this.allProducts = _allProducts,
    this.cartIds = const {},
  });

  List<ShopProduct> get filtered {
    return allProducts.where((p) {
      final matchCat = selectedCategory == 'All Collections' ||
          p.category == selectedCategory;
      final matchSearch = searchQuery.isEmpty ||
          p.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();
  }

  int get cartCount => cartIds.length;

  ShopState copyWith({
    String? selectedCategory,
    String? searchQuery,
    Set<String>? cartIds,
  }) =>
      ShopState(
        selectedCategory: selectedCategory ?? this.selectedCategory,
        searchQuery: searchQuery ?? this.searchQuery,
        allProducts: allProducts,
        cartIds: cartIds ?? this.cartIds,
      );
}

// ── Provider ───────────────────────────────────────────────────────────────────

class ShopNotifier extends Notifier<ShopState> {
  @override
  ShopState build() => const ShopState();

  void selectCategory(String cat) =>
      state = state.copyWith(selectedCategory: cat);

  void search(String q) => state = state.copyWith(searchQuery: q);

  void addToCart(String id) {
    final newSet = {...state.cartIds, id};
    state = state.copyWith(cartIds: newSet);
  }
}

final shopProvider = NotifierProvider<ShopNotifier, ShopState>(
  ShopNotifier.new,
);

final shopCategoriesProvider =
    Provider<List<String>>((_) => _shopCategories);
