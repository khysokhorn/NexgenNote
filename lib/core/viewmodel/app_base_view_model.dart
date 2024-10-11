import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:stacked/stacked.dart';

import '../model/error/no_network_connection_error.dart';

abstract class AppBaseViewModel extends BaseViewModel {
  bool isNoNetworkConnection() {
    return hasError && modelError is NoNetworkConnectionError;
  }

  Future<void> getInstance();
}
