import 'dart:async';
import 'dart:convert';
// ignore: library_prefixes
import 'dart:io' as Io;
import 'dart:io';
import 'dart:math';

import 'package:noteapp/core/constant/general_constants.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/utill/dimensions.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utill/app_constants.dart';
import 'enums/screen_type.dart';
import 'model/error/no_network_connection_error.dart';
import 'services/api_provider_service.dart';
import 'services/global_service.dart';

class GlobalFunction {
  ///Handle log printing in debug build
  static printDebugMessage(data) {
    if (!kReleaseMode) {
      if (data.toString().length < 2000) {
        Logger().d(data);
      }
    }
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  ///On http request fail handler
  static onHttpRequestFail(dynamic error, BaseViewModel model) {
    try {
      if (error is DioException) {
        if (error.response?.statusCode == 419 ||
            error.response?.statusCode == 401 ||
            error.response?.statusCode == 400) {
          if (error.response?.statusCode == 419 ||
              error.response?.statusCode == 401) {
            ApiProviderService().clearUserAccessToken();
            showAlert(
                message:
                    error.response?.data['detail'] ?? "Something went wrong",
                buttonTitle: "OK");
          } else if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.sendTimeout ||
              error.response?.data == null) {
            if (error is NoNetworkConnectionError) {
              model.setError(error);
            } else if (error.type == DioExceptionType.connectionTimeout) {
              model.setError("Request Timeout");
              // model.setError(LocaleKeys.text_connectingTimeout.tr());
            } else {
              model.setError("Connection fail.");
            }
          } else {
            model.setError(error.response?.data["detail"]);
            showAlert(
                message:
                    error.response?.data['title'] ?? "Something went wrong",
                buttonTitle: "OK");
            // ??    LocaleKeys.text_failConnectServer.tr());
          }
        } else {
          model.setError("Somethign went wrong.");
        }
      } else {
        showAlert(message: "Something went wrong", buttonTitle: "OK");
      }
    } catch (error) {
      showAlert(message: "Something went wrong", buttonTitle: "OK");
      model.setError("Somethign went wrong.");
    }
  }

  static int? convertYYYYMMDD_T_HHMMSS_DateTimeToMiliseconds(String? datetime) {
    if (datetime == null) {
      return null;
    }
    return DateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
        .parse(datetime)
        .millisecondsSinceEpoch;
  }

  /// If gender is "FEMALE" or "MALE" and after this function called, it will return the beginning character "F" or "M"
  static String formatShortcutGenderString(String? gender) {
    if (gender == null || gender.isEmpty) {
      return "";
    }

    return gender[0].toString().toUpperCase();
  }

  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }

    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateString);
  }

  /// dateString must be string of date in format "yyyy-MM-dd'T'HH:mm:ss"
  static String formatDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    var formattedDateString = DateFormat("dd/MM/yyyy")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateString));

    return formattedDateString;
  }

  static String formatLAFDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    var formattedDateString = DateFormat("dd,MM,yyyy hh:mm a")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateString));

    return formattedDateString;
  }

  static String formatDateString2(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    var formattedDateString = DateFormat("dd/MM/yy")
        .format(DateFormat("dd-MMM-yyyy").parse(dateString));

    return formattedDateString;
  }

  static String formatDateDDMMYYYY(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    var formattedDateString = DateFormat("dd/MM/yyyy")
        .format(DateFormat("yyyy/MM/dd").parse(dateString));

    return formattedDateString;
  }

  static String formatDateDDMMYYYY2(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    var formattedDateString = DateFormat("dd/MM/yyyy")
        .format(DateFormat("yyyy-MM-dd").parse(dateString));

    return formattedDateString;
  }

  static displayGoogleMap(String? coordinate) {
    if (coordinate != null) {
      launch(
          "https://www.google.com/maps/search/?api=1&query=${coordinate.replaceAll(" ", "")}");
    }
  }

  static Future<Io.File?> writeImageFileFromBase64(
      {required String base64Image, String? fileName}) async {
    final decodedBytes = base64Decode(base64Image);

    final directory = await getTemporaryDirectory();
    final path = directory.path;

    var file = Io.File(fileName != null
        ? "$path/${fileName.replaceAll(RegExp(r"[/\\\s]"), "")}"
        : "$path/img_${DateTime.now().millisecond}.jpg");

    return file.writeAsBytes(decodedBytes);
  }

  static bool isCompletelyKhmerText(String? text) {
    if (text == null) {
      return true;
    }

    var isKhmer = true;

    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      var code = char.codeUnits;

      // if (code.single < 0x1780 || (code.single > 0x17FF && code.single < 0x19E0) || code.single > 0x19FF) {
      //   isKhmer = false;
      //   break;
      // }

      if (code.single < 0x1780 || code.single > 0x17FF) {
        isKhmer = false;
        break;
      }
    }

    return isKhmer;
  }

  /// Used to calculate age from current date
  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  /// Used to calculate age from current date and it returns array with 3 elements corresponding with years, months and days
  static List<int> calculateAge2(DateTime birthDate) {
    List<int> age = [0, 0, 0];

    DateTime now = DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = DateTime(now.year, now.month - 1, birthDate.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    age[0] = years;
    age[1] = months;
    age[2] = days;

    return age;
  }

  static String createImageFileName([String? path]) {
    if (path == null) {
      return 'IMG_${DateTime.now().microsecondsSinceEpoch}';
    }

    return 'IMG_${p.basenameWithoutExtension(path).replaceAll("image_picker", "")}';
  }

  static bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }

    return RegExp(r"^[0-9]+$").hasMatch(str);
  }

  static bool isNumberType(dynamic value) {
    if (value == null) {
      return false;
    }

    return value is int || value is double;
  }

  /// Check if provided date with format dd/mm/yyyy is exactly valid
  static bool isValidDDMMYYYY(String? date) {
    if (date == null || date.isEmpty) {
      return false;
    }

    // return RegExp(r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$").hasMatch(date);

    String dateSt = date.split("/").reversed.join("/");

    return RegExp(
            r"^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$")
        .hasMatch(dateSt);
  }

  static List<T> removeDuplicatedListElement<T>(List<T> list,
      {required bool Function(T element1, T element2) areEqual}) {
    List<T> results = [];

    for (var e in list) {
      if (results.indexWhere((element) => areEqual(e, element)) >= 0) {
        continue;
      }

      results.add(e);
    }

    return results;
  }

  static Future<File?> writeTextFileToDocumentDirectly(String text) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File(
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_laf_error_log.json');
      await file.writeAsString(text);
      return file;
    } catch (e) {
      GlobalFunction.printDebugMessage("Couldn't read file");
      return null;
    }
  }

  static getCurrentDateYYYYMMDD() {
    var dateTime = DateTime.now();
    var format = Jiffy.parseFromDateTime(DateTime(dateTime.year, dateTime.month,
        dateTime.day, dateTime.hour, dateTime.minute));
    return format.format(pattern: "yyyy-MM-dd");
  }
}

Future<dynamic> startNewScreen(ScreenType screenType, Widget widget) {
  if (screenType == ScreenType.SCREEN_WIDGET_REPLACEMENT) {
    return GlobalService().navigator.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        );
  } else {
    return GlobalService().navigator.currentState!.push(
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        );
  }
}

Future<dynamic> startNewScreenAnimation(ScreenType screenType, Widget widget) {
  if (screenType == ScreenType.SCREEN_WIDGET_REPLACEMENT) {
    return Navigator.of(GlobalService().context)
        .pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: const Duration(milliseconds: 700),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  } else {
    return Navigator.of(GlobalService().context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: const Duration(milliseconds: 700),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }
}

exitToTopScreen() {
  Navigator.of(GlobalService().context).popUntil((route) => route.isFirst);
}

showAlert(
    {String? title,
    required String message,
    String? buttonTitle,
    VoidCallback? onPress,
    Color? titleColor = COLOR_ERROR}) {
  return showDialog<void>(
    context: GlobalService().context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        titleTextStyle: TextStyle(
          color: titleColor,
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(buttonTitle != null ? buttonTitle.toUpperCase() : ''
                // : LocaleKeys.button_ok.tr().toUpperCase(),
                ),
            onPressed: () {
              Navigator.of(context).pop();
              onPress?.call();
            },
          ),
        ],
      );
    },
  );
}

showConfirmAlert({
  String? title,
  required String message,
  String? positiveButtonTitle,
  String? negativeButtonTitle,
  Color? positiveButtonTitleColor,
  Color? negativeButtonTitleColor,
  VoidCallback? onPositiveButtonPress,
  VoidCallback? onNegativeButtonPress,
}) {
  return showDialog<void>(
    context: GlobalService().context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        titleTextStyle: const TextStyle(
          color: COLOR_ERROR,
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              negativeButtonTitle != null
                  ? negativeButtonTitle.toUpperCase()
                  : "",
              // : LocaleKeys.button_cancel.tr().toUpperCase(),
              style: theme.bodySmall!.copyWith(
                  color: negativeButtonTitleColor ??
                      COLOR_SURFACE_MEDIUM_EMPHASIS),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onNegativeButtonPress != null) {
                onNegativeButtonPress();
              }
            },
          ),
          TextButton(
            child: Text(
              positiveButtonTitle != null
                  ? positiveButtonTitle.toUpperCase()
                  : "",
              // : LocaleKeys.button_ok.tr().toUpperCase(),
              style: theme.bodySmall!
                  .copyWith(color: positiveButtonTitleColor ?? PRIMARY_COLOR),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onPositiveButtonPress != null) {
                onPositiveButtonPress();
              }
            },
          ),
        ],
      );
    },
  );
}

showOptionSelectionDialog({
  required String title,
  required String contentMsg,
  //required List<String> options,
  //required void Function(int) onSelected,
  VoidCallback? onConfirmPress,
  VoidCallback? onCancelPress,
}) async {
  return showDialog<void>(
    context: GlobalService().context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        contentPadding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 16,
        ),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 280,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      title,
                      style: theme.headlineMedium,
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.loose,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 33.0),
                        child: Text(""),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          // LocaleKeys.button_cancel.tr().toUpperCase(),
                          style: theme.bodySmall!
                              .copyWith(color: COLOR_SURFACE_DISABLED),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          onConfirmPress?.call();
                        },
                        child: Text(
                          // LocaleKeys.button_confirm.tr().toUpperCase() ??
                          "Confirm",
                          style:
                              theme.bodySmall!.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

String formatCurrencyNumber(double? amount) {
  final formatter = NumberFormat("#,###");
  return formatter.format(amount);
}

String formatCurrencyIntegerNumber(int amount) {
  final formatter = NumberFormat("#,###");
  return formatter.format(amount);
}

String formatCurrency2DigitDouble(double amount) {
  final formatter = NumberFormat("#,###.0#");
  return formatter.format(amount);
}

String formatCurrency2DigitDoubleWithNullable(double? amount) {
  if (amount == null) {
    return '-';
  } else {
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(amount);
  }
}

String formatNumberBaseOnCurrency(double? amount, String? ccy) {
  if (amount == null) {
    return '-';
  }
  if (ccy == null) {
    return '-';
  }
  if (ccy == "USD") {
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(amount);
  } else {
    final formatter = NumberFormat("#,###");
    return formatter.format(amount);
  }
}

String nullable(dynamic value) {
  if (value == null) {
    return '-';
  }
  return value.toString();
}

String formatCurrency(double? amount, Currency currency) {
  if (amount == null) {
    return '-';
  }
  final formatter =
      NumberFormat(currency == Currency.usd ? "#,##0.00" : "#,###");
  return formatter.format(amount);
}

String expiredDateAccount(DateTime dateTime, int durationMonth) {
  var format = Jiffy.parseFromDateTime(
          DateTime(dateTime.year, dateTime.month, dateTime.day))
      .add(months: durationMonth);

  return format.format(pattern: "dd/MM/yyyy");
}

String dateFormatAutomatedLoan(DateTime dateTime) {
  var format = Jiffy.parseFromDateTime(DateTime(dateTime.year, dateTime.month,
      dateTime.day, dateTime.hour, dateTime.minute));

  return format.format(pattern: "dd/MM/yyyy");
}

String dateFormatAutomatedLoanSubmit(String dateTime) {
  var format = Jiffy.parse(dateTime, pattern: "dd/MM/yyyy");
  return format.format(pattern: "yyyy-MM-dd");
}

String currentDateFormat(DateTime dateTime) {
  var format = Jiffy.parseFromDateTime(DateTime(dateTime.year, dateTime.month,
      dateTime.day, dateTime.hour, dateTime.minute));
  return format.format(pattern: "dd . MMM . yyyy - HH:mm");
}

String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAllMapped(
      RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "${m[1]} ${m[2]} ${m[3]}");
}

String dateFormatDDMMYYYY(String dateTime) {
  var format = Jiffy.parse(dateTime, pattern: "dd/MM/yyyy");
  return format.format(pattern: "dd/MM/yyyy");
}

String convertDateTime(String? dateTime, String dateFormat) {
  if (dateTime == null) {
    return '-';
  } else {
    /// Convert into local date format.
    var localDate = DateTime.parse(dateTime).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat(dateFormat);
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}

customSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    text,
    maxLines: 2,
  )));
}

double roundKHRCurrency(double amount) {
  final finalAmount = amount.floorToDouble();
  final remaining = finalAmount % 100;
  return ((finalAmount / 100).ceil() * 100);
  // return finalAmount == 0 ? 0 : finalAmount + (100 - remaining);
}
