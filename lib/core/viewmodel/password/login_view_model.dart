import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheet;
import 'package:noteapp/core/enums/screen_type.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/google_api_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:noteapp/core/viewmodel/app_base_view_model.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';

class LoginViewModel extends AppBaseViewModel {
  final GoogleApiService _googleApiService = GoogleApiService();

  @override
  Future<void> getInstance() async {
    await LocalService().getInstance();
    try {
      setInitialised(true);
      _googleApiService.initData();
      notifyListeners();
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> handleSignIn() async {
    try {
      setBusy(true);
      await _googleApiService.signIn();
      setBusy(false);
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }
}
