import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/services/screens/services_screen.dart';
import '../../features/shop/screens/shop_screen.dart';
import '../../features/shop/screens/product_detail_screen.dart';
import '../../features/shop/screens/cart_screen.dart';
import '../../features/bookings/screens/my_bookings_screen.dart';
import '../../features/bookings/screens/booking_confirmation_screen.dart';
import '../../features/learn/screens/learn_screen.dart';
import '../../features/account/screens/account_screen.dart';
import '../../features/services/screens/service_detail_screen.dart';
import '../../features/orders/screens/track_order_screen.dart';
import '../../features/shop/screens/checkout_screen.dart';
import '../../features/admin/screens/manage_bookings_screen.dart';
import '../../features/admin/screens/new_booking_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // ── Splash ─────────────────────────────────────────────────────────
    GoRoute(
      path: '/splash',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const SplashScreen(),
    ),

    // ── Onboarding (first-launch flow, no bottom nav) ─────────────────
    GoRoute(
      path: '/onboarding',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ── Auth screens (no bottom nav) ──────────────────────────────
    GoRoute(
      path: '/login',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '+91 XXXXXX';
        return OtpScreen(phoneOrEmail: phone);
      },
    ),

    // ── Detail screens (no bottom nav) ──────────────────────────────────
    GoRoute(
      path: '/product/:id',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '1';
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/cart',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/my-bookings',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const MyBookingsScreen(),
    ),
    GoRoute(
      path: '/booking-confirmation',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const BookingConfirmationScreen(),
    ),
    GoRoute(
      path: '/service/:id',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '1';
        return ServiceDetailScreen(serviceId: id);
      },
    ),
    GoRoute(
      path: '/track-order/:id',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'RJ88291';
        return TrackOrderScreen(orderId: id);
      },
    ),
    GoRoute(
      path: '/checkout',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const CheckoutScreen(),
    ),
    
    // ── Admin screens ───────────────────────────────────────────────────
    GoRoute(
      path: '/admin/bookings',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ManageBookingsScreen(),
    ),
    GoRoute(
      path: '/admin/new-booking',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const NewBookingScreen(),
    ),

    // ── Main app shell with 5-tab bottom nav ────────────────────────────
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _calculateSelectedIndex(state.uri.path),
            onTap: (int index) => _onItemTapped(index, context),
            selectedItemColor: const Color(0xFFC9847A),
            unselectedItemColor: const Color(0xFF857370),
            backgroundColor: const Color(0xFFF5EFE6),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.spa_outlined), activeIcon: Icon(Icons.spa), label: 'Services'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: 'Shop'),
              BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), activeIcon: Icon(Icons.play_circle), label: 'Learn'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Account'),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/services',
          builder: (context, state) => const ServicesScreen(),
        ),
        GoRoute(
          path: '/shop',
          builder: (context, state) => const ShopScreen(),
        ),
        GoRoute(
          path: '/learn',
          builder: (context, state) => const LearnScreen(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),
  ],
);

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/home')) return 0;
  if (location.startsWith('/services')) return 1;
  if (location.startsWith('/shop')) return 2;
  if (location.startsWith('/learn')) return 3;
  if (location.startsWith('/account')) return 4;
  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go('/home');
      break;
    case 1:
      context.go('/services');
      break;
    case 2:
      context.go('/shop');
      break;
    case 3:
      context.go('/learn');
      break;
    case 4:
      context.go('/account');
      break;
  }
}
