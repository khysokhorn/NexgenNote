import 'package:dio/dio.dart';

class NoNetworkConnectionError extends DioException {
  NoNetworkConnectionError(RequestOptions options) : super(
    requestOptions: options,
    error: "NoNetworkConnection",
    type: DioExceptionType.unknown,
  );
}