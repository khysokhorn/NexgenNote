import 'package:noteapp/core/services/network_info_service.dart';
import 'package:noteapp/core/web_service/local_service.web.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../enums/local_service.dart';
import '../model/error/no_network_connection_error.dart';
import '../repositories/api_repository.dart';
import '../utill/app_constants.dart';

class ApiProviderServiceWeb {
  ApiProviderServiceWeb._apiConstructor();

  static final ApiProviderServiceWeb _instance =
      ApiProviderServiceWeb._apiConstructor();

  factory ApiProviderServiceWeb() {
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
              "Authorization":
                  "Bearer ${LocalServiceWeb().getSavedValue(LocalDataFieldName.USER_TOKEN)}",
            }
          : {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization":
                  "Bearer ${LocalServiceWeb().getSavedValue(LocalDataFieldName.USER_TOKEN)}",
            },
    ),
  );

  Dio get getDioInstance => _dio;

  RestClient getRestClient() {
    getInstance();
    return RestClient(ApiProviderServiceWeb().getDioInstance);
  }

  Dio createDioInstance() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        baseUrl: BASE_API_URL,
        headers: {
          "Authorization": _dio.options.headers["Authorization"],
        },
      ),
    );

    // if (!kReleaseMode) {
    //   dio.interceptors.add(
    //     PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: false,
    //       error: true,
    //       compact: true,
    //     ),
    //   );
    // }

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
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
    // if (!kReleaseMode) {
    //   _dio.interceptors.add(
    //     PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: false,
    //       error: true,
    //       compact: true,
    //     ),
    //   );
    // }

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
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

  }

  setUserAccessToken(String accessToken, {int? expiredDateTime}) {
    if (expiredDateTime != null) {
      LocalServiceWeb().saveValue(
          LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIME, expiredDateTime);
    }
    LocalServiceWeb().saveValue(LocalDataFieldName.USER_TOKEN, accessToken);
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
  }

  clearUserAccessToken() {
    LocalServiceWeb().deleteSavedValue(LocalDataFieldName.USER_TOKEN);
    LocalServiceWeb()
        .deleteSavedValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIME);
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  String? get authorization => _dio.options.headers['Authorization'];

  bool matchesAuthorization(RequestOptions otherOptions) {
    return authorization == otherOptions.headers['Authorization'];
  }

  copyAuthorizationTo(RequestOptions otherOptions) {
    otherOptions.headers['Authorization'] =
        _dio.options.headers['Authorization'];
  }

  replaceNewAuthorizationIfDirty(RequestOptions otherOptions) {
    if (otherOptions.headers['Authorization'] !=
        _dio.options.headers['Authorization']) {
      otherOptions.headers['Authorization'] =
          _dio.options.headers['Authorization'];
    }
  }
}
