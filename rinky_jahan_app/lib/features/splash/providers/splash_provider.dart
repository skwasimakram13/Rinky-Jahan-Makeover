import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Returns the destination route after the splash delay.
/// - First launch  → '/onboarding'
/// - Returning user → '/home'
class SplashNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    // Simulate loading / session check (2.5 s)
    await Future.delayed(const Duration(milliseconds: 2500));
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_done') ?? false;
    return done ? '/home' : '/onboarding';
  }
}

final splashProvider = AsyncNotifierProvider<SplashNotifier, String>(
  SplashNotifier.new,
);

