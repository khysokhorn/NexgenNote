import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../generated/locale_keys.g.dart';
import '../global_function.dart';
import '../services/api_provider_service.dart';
import '../services/global_service.dart';

class SettingViewModel extends BaseViewModel {
  bool allowDownloadUpload = false;
  bool allowSubmitLAFStatus = false;
  bool allowSubmitCustomerProfileStatus = false;
  bool allowAnnouncement = false;
  Map<String, Locale> locales = {
    "en": const Locale("en", "US"),
    "km": const Locale("km", "KH"),
  };

  getInstance() async {
    clearErrors();
    setBusy(false);
    getData();
    setInitialised(true);
    notifyListeners();
  }

  getData() async {
    try {} catch (e) {
      GlobalFunction.onHttpRequestFail(e, this);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  String get selectedLangCode {
    return GlobalService().context.locale.languageCode;
  }

  /// Tell whether or not all notification types are enabled
  bool get areAllNotificationTypesAllowed {
    return allowDownloadUpload &&
        allowSubmitLAFStatus &&
        allowSubmitCustomerProfileStatus &&
        allowAnnouncement;
  }

  languageSetting() async {
    // await GlobalService().pushNavigation(const LanguageView());
    notifyListeners();
  }

  changeLang(lan) {
    var locale = locales[lan];
    if (locale != null) {
      GlobalService().context.setLocale(locale);
    }
    notifyListeners();
  }

  String getDisplayedSelectedLanguage() {
    return GlobalService().context.locale.languageCode == "en"
        ? "English"
        : "Khmer";
  }

  _deleteAllDrafts() async {
    try {
      setBusy(true);
      notifyListeners();
      showAlert(message: "All drafts are cleared successfully");
    } catch (error) {
      GlobalFunction.onHttpRequestFail(error, this);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  signOut() {
    showConfirmAlert(
      message: LocaleKeys.settings_signOut.tr(),
      onPositiveButtonPress: () async {
        try {
          setBusy(true);
          notifyListeners();
        } catch (error) {
          GlobalFunction.printDebugMessage(error);
        } finally {
          setBusy(false);
          notifyListeners();
          // ApiProviderService().clearUserAccessToken();
          exitToTopScreen();
          // startNewScreen(
          //     ScreenType.SCREEN_WIDGET_REPLACEMENT, const LoginView());
        }
      },
    );
  }
}
