import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../enums/local_service.dart';
import '../global_function.dart';
import '../services/api_provider_service.dart';
import '../services/global_service.dart';
import '../services/local_service.dart';
import '../utill/app_constants.dart';

class AuthenticationInterceptor extends QueuedInterceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('Authorization')) {
      final shouldRenewToken = await _shouldRenewToken();

      if (shouldRenewToken) {
        final success = await _showLoginDialog();

        if (success == true) {
          ApiProviderService().copyAuthorizationTo(options);
        }
      } else {
        if (options.headers.containsKey('OverridingAuthorization')) {
          options.headers['Authorization'] =
              options.headers['OverridingAuthorization'];
        } else {
          ApiProviderService().replaceNewAuthorizationIfDirty(options);
        }
      }
    }

    handler.next(options);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (ApiProviderService().matchesAuthorization(err.requestOptions)) {
        try {
          ApiProviderService().copyAuthorizationTo(err.requestOptions);
          final response = await _retryRequest(err.requestOptions);
          handler.resolve(response);
        } catch (error) {
          handler.next(err);
        }
      } else {
        final success = await _showLoginDialog();

        if (success == true) {
          try {
            ApiProviderService().copyAuthorizationTo(err.requestOptions);
            final response = await _retryRequest(err.requestOptions);
            handler.resolve(response);
          } catch (error) {
            handler.next(err);
          }
        } else {
          handler.next(err);
        }
      }
    } else {
      handler.next(err);
    }
  }

  _shouldRenewToken() async {
    final expiredDateTimeInMilliseconds = await LocalService()
        .getSavedValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIME);

    if (expiredDateTimeInMilliseconds != null) {
      final expiredDateTime =
          DateTime.fromMillisecondsSinceEpoch(expiredDateTimeInMilliseconds!);
      final nowDateTime = DateTime.now();
      final minDiff = expiredDateTime.difference(nowDateTime).inMinutes;

      GlobalFunction.printDebugMessage('Will renew token in: $minDiff min');

      if (minDiff <= EARLIER_MINUTES_RENEW_TOKEN) {
        return true;
      }
    }

    return false;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions options) async {
    final retryDio = ApiProviderService().createDioInstance();
    final url = options.uri.toString();
    final reqOpt = options;

    return retryDio.request(url,
        options: Options(
          method: reqOpt.method,
          sendTimeout: reqOpt.sendTimeout,
          receiveTimeout: reqOpt.receiveTimeout,
          extra: reqOpt.extra,
          headers: reqOpt.headers,
          responseType: reqOpt.responseType,
          contentType: reqOpt.contentType,
          validateStatus: reqOpt.validateStatus,
          receiveDataWhenStatusError: reqOpt.receiveDataWhenStatusError,
          followRedirects: reqOpt.followRedirects,
          maxRedirects: reqOpt.maxRedirects,
          requestEncoder: reqOpt.requestEncoder,
          responseDecoder: reqOpt.responseDecoder,
          listFormat: reqOpt.listFormat,
        ));
  }

  Future<bool?> _showLoginDialog() async {
    final success = await showDialog<bool?>(
      context: GlobalService().context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          child: Text("Login dialog"),
        );
      },
    );

    return success;
  }
}
