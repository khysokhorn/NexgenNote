import 'package:noteapp/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

extension FormTextEditingControllerExtension on TextEditingController {
  double doubleValue() {
    return text.replaceAll(RegExp(r','), '').parseDouble();
  }

  int intValue() {
    return text.replaceAll(RegExp(r','), '').parseInt();
  }

  bool get isEmpty => text.isEmpty;

  bool get isNoEmpty => text.isNotEmpty;

  String formatMoneyWithoutSymbol() {
    try {
      return text.isEmpty
          ? ''
          : MoneyFormatter(
                  amount: double.parse(text.replaceAll(RegExp(r','), '')))
              .output
              .withoutFractionDigits;
    } on FormatException {
      return '';
    }
  }

  void setCurrencyText(dynamic value) {
    try {
      text = value != null && (value is double || value is int)
          ? MoneyFormatter(amount: value.toDouble() as double)
              .output
              .withoutFractionDigits
          : value?.toString() ?? '';
    } on FormatException {
      text = '';
    }
  }
}
