import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Auth state ────────────────────────────────────────────────────────────────

enum AuthStatus { idle, loading, otpSent, verified, error }

class AuthState {
  final AuthStatus status;
  final String? phoneOrEmail;
  final String? errorMessage;
  final int resendCountdown; // seconds remaining

  const AuthState({
    this.status = AuthStatus.idle,
    this.phoneOrEmail,
    this.errorMessage,
    this.resendCountdown = 45,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? phoneOrEmail,
    String? errorMessage,
    int? resendCountdown,
  }) =>
      AuthState(
        status: status ?? this.status,
        phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
        errorMessage: errorMessage ?? this.errorMessage,
        resendCountdown: resendCountdown ?? this.resendCountdown,
      );
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  /// Mock email/password login — fast-forwards to OTP for now
  Future<void> loginWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1)); // Mock API call
    // In production: call Supabase auth or backend /login
    state = state.copyWith(
      status: AuthStatus.otpSent,
      phoneOrEmail: email,
    );
  }

  /// Mock phone OTP flow
  Future<void> sendOtp(String phone) async {
    state = state.copyWith(status: AuthStatus.loading, phoneOrEmail: phone);
    await Future.delayed(const Duration(milliseconds: 800));
    // In production: call MSG91 via backend
    state = state.copyWith(status: AuthStatus.otpSent, resendCountdown: 45);
  }

  /// Mock OTP verification
  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));
    // In production: verify with backend / Supabase
    if (otp == '123456') {
      state = state.copyWith(status: AuthStatus.verified);
      return true;
    } else {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid OTP. Please try again.',
      );
      return false;
    }
  }

  void tickResend() {
    if (state.resendCountdown > 0) {
      state = state.copyWith(resendCountdown: state.resendCountdown - 1);
    }
  }

  void reset() => state = const AuthState();
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
