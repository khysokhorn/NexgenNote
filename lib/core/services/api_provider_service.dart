import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../dio_interceptors/authentication_interceptor.dart';
import '../enums/local_service.dart';
import '../model/error/no_network_connection_error.dart';
import '../repositories/api_repository.dart';
import '../utill/app_constants.dart';
import 'local_service.dart';
import 'network_info_service.dart';

class ApiProviderService {
  ApiProviderService._apiConstructor();

  static final ApiProviderService _instance = ApiProviderService._apiConstructor();
  static final LocalService _localService = LocalService().getInstance(); 
  factory ApiProviderService() {
    return _instance;
  }

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      baseUrl: BASE_API_URL,
      headers: kDebugMode
          ? {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Access-Control-Allow-Origin": "*",
            }
          : {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Access-Control-Allow-Origin": "*"
            },
    ),
  );

  Dio get getDioInstance => _dio;

  RestClient getRestClient() {
    return RestClient(ApiProviderService().getDioInstance);
  }

  Dio createDioInstance() {
    print("Token ${_dio.options.headers["Authorization"]}"); 
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
        baseUrl: BASE_URL,
        headers: {
          "Authorization": _dio.options.headers["Authorization"],
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (await NetworkInfoService().isConnected) {
        return handler.next(options); //continue
      } else {
        return handler.reject(NoNetworkConnectionError(options));
      }
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
    return dio;
  }

  getInstance() {
    if (!kReleaseMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (await NetworkInfoService().isConnected) {
        return handler.next(options); //continue
      } else {
        return handler.reject(NoNetworkConnectionError(options));
      }
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    _dio.interceptors.add(AuthenticationInterceptor());
  }

  setUserAccessToken(String accessToken, {int? expiredDateTime}) {
    if (expiredDateTime != null) {
      LocalService().saveValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIME, expiredDateTime);
    }
    LocalService().saveValue(LocalDataFieldName.USER_TOKEN, accessToken);
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
  }

  setUserAccessTokenDateTime(String accessToken, {DateTime? expiredDateTime}) {
    if (expiredDateTime != null) {
      LocalService().saveValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIMEV2, expiredDateTime.toIso8601String());
    }
    LocalService().saveValue(LocalDataFieldName.USER_TOKEN, accessToken);
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
  }

  clearUserAccessToken() {
    // LocalService().deleteSavedValue(LocalDataFieldName.USER_TOKEN);
    // LocalService().deleteSavedValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIME);
    // _dio.options.headers = {
    //   "Content-Type": "application/json",
    //   "Accept": "application/json",
    // };
  }

  String? get authorization => _dio.options.headers['Authorization'];

  bool matchesAuthorization(RequestOptions otherOptions) {
    return authorization == otherOptions.headers['Authorization'];
  }

  copyAuthorizationTo(RequestOptions otherOptions) {
    otherOptions.headers['Authorization'] = _dio.options.headers['Authorization'];
  }

  replaceNewAuthorizationIfDirty(RequestOptions otherOptions) {
    if (otherOptions.headers['Authorization'] != _dio.options.headers['Authorization']) {
      otherOptions.headers['Authorization'] = _dio.options.headers['Authorization'];
    }
  }
}
