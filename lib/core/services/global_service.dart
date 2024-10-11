import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GlobalService {
  GlobalService._apiConstructor();

  static final GlobalService _instance = GlobalService._apiConstructor();

  CancelToken webCancelToken = CancelToken();

  factory GlobalService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigator => _navigator;
  BuildContext get context => _navigator.currentContext!;

  cancelAllPendingRequest([Object? reason]) {
    if (!webCancelToken.isCancelled) {
      webCancelToken.cancel(reason);
    }
  }

  showLoading() async {
    if (GlobalService().context.loaderOverlay.visible) {
      return;
    }
    GlobalService().context.loaderOverlay.show();
  }

  hideLoading() async {
    if (GlobalService().context.loaderOverlay.visible == false) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 10));
    GlobalService().context.loaderOverlay.hide();
  }

  pushNavigation(Widget target,
      {void Function(dynamic result)? callBack}) async {
    var result = await _navigator.currentState!
        .push(MaterialPageRoute(builder: (context) => target));

    callBack?.call(result);

    return result;
  }

  pushReplacementNavigation(Widget target) {
    _navigator.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => target),
    );
  }

  popNavigation({dynamic result}) {
    _navigator.currentState!.pop(result);
  }
}
