import 'dart:io';

import 'package:noteapp/core/enums/local_service.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/Login/login_request.dart';
import 'package:noteapp/core/model/request/Password/request_new_password.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/global_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:noteapp/core/viewmodel/app_base_view_model.dart';
import 'package:noteapp/ui/views/Password/login.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../enums/screen_type.dart';
import '../../utill/app_constants.dart';

class LoginViewModel extends AppBaseViewModel {
  TextEditingController usreNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isChangePassword = false;
  bool isHidden = true;
  bool production = false;
  var key = GlobalKey();
  void togglePasswordView() {
    isHidden = !isHidden;
    notifyListeners();
  }

  @override
  Future<void> getInstance() async {
    try {
      production =
          BASE_URL == "https://www.prathnatech.com:7100" ? true : false;
      if (!production) {
        usreNameController.text = "DAO1_TN";
        passwordController.text = "123";
      }
      if (await checkForUpdate() == true) {
        return;
      }
      setInitialised(true);
      await LocalService().getInstance();
      String? saveLoginDate = await LocalService()
          .getSavedValue(LocalDataFieldName.SAVE_LOGIN_DATE);
      DateTime now = DateTime.now();
      String todayDate = DateFormat('ddMMyyyy').format(now);
      String? token =
          await LocalService().getSavedValue(LocalDataFieldName.USER_TOKEN);
      String? expireDateTime = await LocalService()
          .getSavedValue(LocalDataFieldName.USER_TOKEN_EXPIRED_DATETIMEV2);

      if (expireDateTime != null) {
        var expireDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(expireDateTime);
        var shouldReNew = expireDate.difference(DateTime.now()).inSeconds <= 0;
        if (saveLoginDate != null && saveLoginDate != todayDate) {
          await LocalService().deleteAll();
          shouldReNew = true; // set for relogin for cross day
        }
        if (token?.isNotEmpty == true && !shouldReNew) {
          if (!isChangePassword) {
            ApiProviderService().setUserAccessTokenDateTime(token ?? "",
                expiredDateTime: expireDate);
            await getUserProfile();
            GlobalService().pushReplacementNavigation(const HomeScreen());
          }
        }
      }
      notifyListeners();
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
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

  Future<void> postLogin() async {
    setBusy(true);
    notifyListeners();
    var request = LoginRequest(
        userName: usreNameController.text.trim(),
        password: passwordController.text.trim());
    DateTime now = DateTime.now();
    String saveTodayDate = DateFormat('ddMMyyyy').format(now);
    try {
      var login = await ApiProviderService().getRestClient().postLogin(request);
      if (login.data.expiredDate != null) {
        ApiProviderService().setUserAccessTokenDateTime(login.token,
            expiredDateTime: DateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
                .parse(login.data.expiredDate!));
        LocalService()
            .saveValue(LocalDataFieldName.USER_ROLE, login.data.userRole);
        LocalService()
            .saveValue(LocalDataFieldName.SAVE_LOGIN_DATE, saveTodayDate);
      }

      await getUserProfile();
      setBusy(false);
      notifyListeners();
      GlobalService().pushReplacementNavigation(HomeScreen());
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }

  getUserProfile() async {
    try {
      UserProfileModel response =
          await ApiProviderService().getRestClient().getUserProfile();
      await LocalService()
          .saveValue(LocalDataFieldName.USER_PROFILE, response.toJson());
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }

  changePassword() {
    isHidden = !isHidden;
    notifyListeners();
  }

  var newPassIsHidden = true;
  newPasswordChange() {
    newPassIsHidden = !newPassIsHidden;
    notifyListeners();
  }

  var confirmPasswordIsHidden = true;
  confirmChangePassword() {
    confirmPasswordIsHidden = !confirmPasswordIsHidden;
    notifyListeners();
  }

  setNewPassword() async {
    setBusy(true);
    notifyListeners();
    var request = RequestNewPassword(
        currentPassword: passwordController.text.trim(),
        newPassword: newPasswordController.text.trim());
    try {
      var login =
          await ApiProviderService().getRestClient().changePassword(request);
      if (login.status == true) {
        await LocalService().deleteAll();
        setBusy(false);
        notifyListeners();
        await startNewScreenAnimation(
            ScreenType.SCREEN_WIDGET_REPLACEMENT, const LoginView());
      }
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<bool?> checkForUpdate() async {
    try {
      String currentVersion = await _getAppVersion();
      bool updateRequired = await _needsUpdate(currentVersion);
      if (updateRequired) {
        _showUpdateDialog(GlobalService().context);
      }
      return updateRequired;
    } catch (e) {
      return false;
    }
  }

// Call `checkForUpdate` in your main widget's `initState` or similar lifecycle method.

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<bool> _needsUpdate(String currentVersion) async {
    String? latestVersion = await getLatestVersionFromServer(); // Or Play Store
    return currentVersion != latestVersion;
  }

  Future<String?>? getLatestVersionFromServer() async {
    var res = await ApiProviderService().getRestClient().getAppVersion();
    return res.data?.version;
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Available"),
          content: Text(
              "A new version of the app is available. Please update to continue."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exit(0);
              },
              child: const Text("Later"),
            ),
            TextButton(
              onPressed: () {
                _redirectToPlayStore();
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _redirectToPlayStore() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.prathna.tech";
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $url";
    }
  }
}
