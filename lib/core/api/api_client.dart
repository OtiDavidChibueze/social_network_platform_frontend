import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_network_platform/core/api/token/token_interception.dart';
import 'package:social_network_platform/core/constants/api_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:social_network_platform/core/di/locator.dart';

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    Dio dio = getIt<Dio>();
    dio.options.baseUrl = '${ApiConfig.BASE_URL}api/';
    if (tokenInterceptor) {
      dio.interceptors.add(
        TokenInterception(dio: dio, firebaseAuth: getIt<FirebaseAuth>()),
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
