import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoService {
  static final NetworkInfoService _instance = NetworkInfoService._();

  late Connectivity _connectivity;

  NetworkInfoService._() {
    _connectivity = Connectivity();
  }

  factory NetworkInfoService() {
    return _instance;
  }

  StreamSubscription<ConnectivityResult> addListener(
      void Function(bool isConnected)? listener) {
    return _connectivity.onConnectivityChanged.listen((result) {
      listener?.call(result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile);
    });
  }

  Future<bool> get isConnected async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
