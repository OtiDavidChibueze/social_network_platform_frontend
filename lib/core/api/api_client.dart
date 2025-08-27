import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:social_network_platform/core/api/api_config.dart';
import 'package:social_network_platform/core/api/token/token_interception.dart';

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "${ApiConfig.baseUrl}api/",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    if (tokenInterceptor) {
      dio.interceptors.add(
        TokenInterception(dio: dio, firebaseAuth: FirebaseAuth.instance),
      );
    }

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true,
      ),
    );

    return dio;
  }
}
