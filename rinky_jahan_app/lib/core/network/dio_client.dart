import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000', // Backend URL placeholder
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token from secure storage here later
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle global success scenarios
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle global errors, token refresh, or analytics logging
        return handler.next(e);
      },
    ),
  );

  return dio;
});
