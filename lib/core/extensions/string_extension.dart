import 'package:noteapp/core/constant/general_constants.dart';

extension StringExtension on String {
  int parseInt() {
    try {
      return isEmpty ? 0 : int.parse(double.parse(this).toStringAsFixed(0));
    } on FormatException {
      return 0;
    }
  }

  double parseDouble() {
    try {
      return isEmpty ? 0.0 : double.parse(this);
    } on FormatException {
      return 0.0;
    }
  }

  String withPercentSymbolSuffix() {
    return this + "%";
  }

  String removeComma() {
    return replaceAll(',', '');
  }

  Currency getCurrency() =>
      toLowerCase() == "usd" ? Currency.usd : Currency.khr;
}
