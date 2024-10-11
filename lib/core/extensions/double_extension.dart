import 'dart:math';

import 'package:money_formatter/money_formatter.dart';

extension DoubleExtension on double {
  double to2Precisions() {
    return double.parse(toStringAsFixed(2));
  }

  String withPercentSymbolSuffix() {
    return toStringAsFixed(2) + "%";
  }

  String formatMoneyWithoutSymbol() {
    return MoneyFormatter(amount: this).output.withoutFractionDigits;
  }

  String convertToString() {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    String s = toString().replaceAll(regex, '');

    return s;
  }

  /// Function for rounding up or down for currency amount with 2 precisions
  ///
  /// Must be round up or round down follow policy
  /// 1. 2,005.155 USD => Must round up to 2,005.16 USD
  //  2. 2,005.154 USD => Must round down to 2,005.15
  double roundUpDownWith2PrecisionCurrency() {
    num mod = pow(10, 2);
    return ((this * mod).round().toDouble() / mod);
  }

 
}
