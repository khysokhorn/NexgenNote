import 'package:flutter/material.dart';

class GlobalService {
  GlobalService._apiConstructor();

  static final GlobalService _instance = GlobalService._apiConstructor();

  factory GlobalService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigator => _navigator;
  BuildContext get context => _navigator.currentContext!;

  pushNavigation(Widget target, {void Function(dynamic result)? callBack}) async {
    var result = await _navigator.currentState!.push(MaterialPageRoute(builder: (context) => target));
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
