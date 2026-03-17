import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Model ────────────────────────────────────────────────────────────────────

class OnboardingSlide {
  final String kicker;
  final String headline;
  final String body;
  final String imageUrl;
  final String? secondaryImageUrl;

  const OnboardingSlide({
    required this.kicker,
    required this.headline,
    required this.body,
    required this.imageUrl,
    this.secondaryImageUrl,
  });
}

// ── Mock data ─────────────────────────────────────────────────────────────────

const _slides = [
  OnboardingSlide(
    kicker: 'THE ETHEREAL ATELIER',
    headline: 'Book Your Glow',
    body: 'Schedule spa & salon services in minutes. Experience a digital sanctuary of beauty.',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBzK_LnciK4Ih4aZwSKehWvEZaWdL8iV_3GKYdCMUwYoWTwa3ACxT4j-PHMyFjauIZdjL7IkGlGV76aBd7h5j3-70gBqk60cWkUBV0bufRzUAKJCBCNHZyuxhk3g53oS1JC-ULPv23TnT4CdsO8QIVYUrufBC31qYhpmXR4aF7nOgO1uJppCwp0bdiDpRIUI4265DgDMLwdMs8XZk1lgJJwm8tv9L5bFzra_MT8yDQP239CfDHjncNKvBB2kS0H9VpKJUwK5PnkNBE',
  ),
  OnboardingSlide(
    kicker: 'CURATED COLLECTION',
    headline: 'Shop Beauty Essentials',
    body: 'Explore our curated beauty products, handpicked by professionals for your unique skin needs.',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB3D-ScdbRotNT7VgzxhkcgUOEZa37m1bamm4RYI-UeIm9s5bVHQHCkaqHSFiiJOQn4XdnqH8WLaW-GBSIjzcgClPkp4DqDaxoMKYFYPcwFFzeXuQ9gz32YfJ_0JGfuQ-wFAkwMvXSGdve4CDEPer4sOgNvsqaE5Po2AYMeAdw_UVx6fsFMKrMcghq0rR34MkreUwCYCngDjpJ8CwqkIEA_BRpjn0cMim3WPCazkYGhLtSxEsppeCa3IenNYmxb1HKhHhSj3laNTTg',
    secondaryImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDrwRURHvg6GDDjeBh_Ce4gtnOsVbUbvaBvBQiigUjT4w67ReBIKEl3wQQ2N0yy4Hen7YqzZxOZu6On7dS7bmxkd0mmejYCHvrCHOw_XAOg5gVS21KP28x4-X7Ad6sN8SXbZ-HWTnICA4zA1gDItdHyrc1W5HQka3GBD7MnnBHcpLURflOiYttvI9n3mF5gqZqKHIWPHRnmQIFMyR3Cb4Hk9BdzP_y0JwQkHqySSJPjcaTOdmE2nJaFtHHRSoSdjvm2vk_vDYymAro',
  ),
  OnboardingSlide(
    kicker: 'LEVEL UP YOUR BEAUTY',
    headline: 'Learn & Grow',
    body: 'Watch expert tutorials from our artists and master the art of ethereal transformation from home.',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA-StgUR-o3pPVYxIsVl2XJCHvhayuyBwIpgeGUiSikfKmSvwhPAYFqqqoW99UT84PGLVrrhDRYTG4cy58aEr0HYW9B05_VRY2Wophr8W6Q0dsze9nk3sOAWtE1f8AB47_vig0ZfxA6fQTQsvx2Mt1r91xEHxhLiS97XKOLs_rcSDOqqDQwEOWXmrp6jdGT7vEVSOPAtP2Thp27HPT4rnDOLz1qkxJzz3SwdwOpT4gawDT-HFvpf3k1Y1gh4bhfWWNGYSd8YLVXstE',
  ),
];

// ── Provider ──────────────────────────────────────────────────────────────────

class OnboardingNotifier extends Notifier<int> {
  @override
  int build() => 0; // Current slide index

  void nextSlide() {
    if (state < _slides.length - 1) state++;
  }

  void prevSlide() {
    if (state > 0) state--;
  }

  void goToSlide(int index) => state = index;

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
  }
}

/// Current slide index (0-based)
final onboardingPageProvider = NotifierProvider<OnboardingNotifier, int>(
  OnboardingNotifier.new,
);

/// All slides data
final onboardingSlidesProvider = Provider<List<OnboardingSlide>>((ref) => _slides);
