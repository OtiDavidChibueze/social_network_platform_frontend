import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenInterception extends Interceptor {
  final Dio dio;
  final FirebaseAuth firebaseAuth;

  TokenInterception({required this.dio, required this.firebaseAuth});

  int retryCount = 0;
  final int maxRetry = 3;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final user = firebaseAuth.currentUser;
      final token = await user?.getIdToken();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (e) {
      handler.reject(DioException(requestOptions: options, error: e));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && retryCount < maxRetry) {
      retryCount++;

      try {
        final user = firebaseAuth.currentUser;
        final token = await user?.getIdToken();

        if (token != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
        }

        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          queryParameters: err.requestOptions.queryParameters,
          data: err.requestOptions.data,
        );

        retryCount = 0;
        return handler.resolve(response);
      } catch (e) {
        retryCount = 0;
      }
    }

    handler.next(err);
  }
}
