import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Models ────────────────────────────────────────────────────────────────────

class ServiceItem {
  final String id;
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;

  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

// ── Mock data ─────────────────────────────────────────────────────────────────

const _allServices = [
  ServiceItem(
    id: '1',
    name: 'Glow Facial',
    description: 'Deep cleansing & vitamin infusion',
    price: '₹9,999',
    category: 'Skincare',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCmsT8hUHjKTqrFp14h0IG2OanOkx417wRQd61Arfx6NwayqQhl-oHa95u8V79nWeWi3ZExK81DNgdP5CziG2_u288O1Czk_OtlSyXBDnVQmkKa_8eRoih_1JVgSitLmu7-5bf2JGfmn_864vZtI03NI0dAD4c_FEx7pBVNWz7T-Drlt-_E9kIYAipTrVUbdYMQElNeWTN7Lcm9S_Mg5_yXibRQvdYZRXzhi8r030K-MMsgjOjY4OCR5zKJ3KxD9j3bwlJO2DWOUp4',
  ),
  ServiceItem(
    id: '2',
    name: 'Bridal Makeup',
    description: 'Exquisite long-wear bridal look',
    price: '₹29,999',
    category: 'Makeup',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDNi4qBbk_cMUWLko2XkzOrPSf96XVdvDjUqbZBhYqY3DGRn-qNRnAPP-wKJbJLeA22XHCS-iFFAQ_Zk0mauTEeL6KMIYYTct6X9lIBBRzWqJsWw0LVFJJU5_d-O14PDT3LkSK-a99g37zuWiUqUetfM7nD9ZA7SdLC9IiDwdxyf4OecmSHHQOab_plSYzxpUK4N_lf4sUZe_00DbyeS_iVKNvDCsr_4-i5p4oIj9Ypyxp2oPixLxVZrjR4LHqLnC5b9edbSXhQtLg',
  ),
  ServiceItem(
    id: '3',
    name: 'Keratin Therapy',
    description: 'Silky smooth hair restoration',
    price: '₹17,999',
    category: 'Hair',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAo3OIA3R6NmL9bFjVzDRKYeGhm5Hj1wB4tkqFkUKdlgYWBX7OtuhvN9qEQoikeLZCFs2PR_uJKicS-HVLWc1iix10EZgYnXyCknPvkzdLCq7pFx5p4Yawv7dyEJHqHLPqAgLsDxdTZLUb7Qzw7jtOoi1akKUGpFR-_LMX-QbMeeBdG3Ivb3Wva4vfS1y9HEOA3tgE0Zbav7MbTB-JsgZutCJaAPcXTtHadWvFma4YGY52Gi2_sNlbyPSMDPEmbixBd64Ar74KzMuM',
  ),
  ServiceItem(
    id: '4',
    name: 'Petal Manicure',
    description: 'Luxury nail spa treatment',
    price: '₹5,499',
    category: 'Skincare',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBObMnQt7UbLzvXnuZdhM-FQvvBd7O_HCO0lL3TJIx26aSy4968QYkn2a7IJk3sWBgL_qBLkRCYga7gfU7H2uRvs5VMqRxXI7AbboGWTaXNasRBIeSUJ4snaaxTMdS_2M2RJbhMdNIpyV_KQ_lLnwR0ZwjlsIrCXyMU9TOiFH81B5LOEdtiSn8DaaQi5e_WlvZnGL2cqc4hHcsbMhkC27Sx9itldy8ytq3Swtx7stq1p6ea35uQ8e575J1kCWP9ju_uP_rBEKTNli0',
  ),
  ServiceItem(
    id: '5',
    name: 'Royal Spa Package',
    description: 'Full body aromatherapy & massage',
    price: '₹14,999',
    category: 'Makeup',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCmsT8hUHjKTqrFp14h0IG2OanOkx417wRQd61Arfx6NwayqQhl-oHa95u8V79nWeWi3ZExK81DNgdP5CziG2_u288O1Czk_OtlSyXBDnVQmkKa_8eRoih_1JVgSitLmu7-5bf2JGfmn_864vZtI03NI0dAD4c_FEx7pBVNWz7T-Drlt-_E9kIYAipTrVUbdYMQElNeWTN7Lcm9S_Mg5_yXibRQvdYZRXzhi8r030K-MMsgjOjY4OCR5zKJ3KxD9j3bwlJO2DWOUp4',
  ),
  ServiceItem(
    id: '6',
    name: 'Bridal Hair Styling',
    description: 'Elegant bridal hair & accessories',
    price: '₹12,500',
    category: 'Bridal',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAo3OIA3R6NmL9bFjVzDRKYeGhm5Hj1wB4tkqFkUKdlgYWBX7OtuhvN9qEQoikeLZCFs2PR_uJKicS-HVLWc1iix10EZgYnXyCknPvkzdLCq7pFx5p4Yawv7dyEJHqHLPqAgLsDxdTZLUb7Qzw7jtOoi1akKUGpFR-_LMX-QbMeeBdG3Ivb3Wva4vfS1y9HEOA3tgE0Zbav7MbTB-JsgZutCJaAPcXTtHadWvFma4YGY52Gi2_sNlbyPSMDPEmbixBd64Ar74KzMuM',
  ),
];

const _categories = ['All Services', 'Skincare', 'Makeup', 'Hair', 'Bridal'];

// ── State ─────────────────────────────────────────────────────────────────────

class ServicesState {
  final String selectedCategory;
  final String searchQuery;
  final List<ServiceItem> allServices;

  const ServicesState({
    this.selectedCategory = 'All Services',
    this.searchQuery = '',
    this.allServices = _allServices,
  });

  List<ServiceItem> get filtered {
    return allServices.where((s) {
      final matchCat = selectedCategory == 'All Services' ||
          s.category == selectedCategory;
      final matchSearch = searchQuery.isEmpty ||
          s.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          s.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();
  }

  ServicesState copyWith({String? selectedCategory, String? searchQuery}) =>
      ServicesState(
        selectedCategory: selectedCategory ?? this.selectedCategory,
        searchQuery: searchQuery ?? this.searchQuery,
        allServices: allServices,
      );
}

// ── Provider ──────────────────────────────────────────────────────────────────

class ServicesNotifier extends Notifier<ServicesState> {
  @override
  ServicesState build() => const ServicesState();

  void selectCategory(String cat) =>
      state = state.copyWith(selectedCategory: cat);
  void search(String q) => state = state.copyWith(searchQuery: q);
}

final servicesProvider = NotifierProvider<ServicesNotifier, ServicesState>(
  ServicesNotifier.new,
);

final servicesCategoriesProvider =
    Provider<List<String>>((_) => _categories);
