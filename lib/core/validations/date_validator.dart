import 'package:form_validation/form_validation.dart';
import 'package:easy_localization/easy_localization.dart';

class DateValidator extends ValueValidator {

  final DateTime? minDate;
  final DateTime? maxDate;

  DateValidator({this.minDate, this.maxDate});

  DateValidator fromDynamic(dynamic map) {
    DateValidator result = DateValidator();

    if (map != null) {
      assert(map['type'] == type);

      result = DateValidator();
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() => {
        // add additional attributes here
        "type": type,
      };

  @override
  String? validate({
    required String? label,
    required String? value,
  }) {
    String? error;

    // In general, validators should pass if the value is empty.  Combine
    // validators with the RequiredValidator to ensure a value is non-empty.
    if (value?.isNotEmpty == true) {
      try {
        List<String> dmy = value!.split("/");

        if (dmy.isNotEmpty) {
          var day = int.parse(dmy[0]);

          if (day < 1 || day > 31) {
            // error = LocaleKeys.validation_dateFormat.tr();
          } else if (dmy.length > 1) {
            var month = int.parse(dmy[1]);

            if (month < 1 || month > 12) {
              // error = LocaleKeys.validation_dateFormat.tr();
            }
          }
        }

        if (error == null) {
          var date = DateFormat("dd/MM/yyyy").parse(value);

          if (value.split('/')[2].length != 4) {
            throw const FormatException();
          }

          var _minDate = minDate == null
              ? null
              : DateTime(minDate!.year, minDate!.month, minDate!.day);
          var _maxDate = maxDate == null
              ? null
              : DateTime(maxDate!.year, maxDate!.month, maxDate!.day);

          if (_minDate != null && date.isBefore(_minDate)) {
            error =
                "Date cannot be earlier than ${DateFormat('dd/MM/yyyy').format(_minDate)}";
          } else if (_maxDate != null && date.isAfter(_maxDate)) {
            final now = DateTime.now();
            final isMaxDateToday = _maxDate.year == now.year &&
                _maxDate.month == now.month &&
                _maxDate.day == now.day;

            if (isMaxDateToday) {
              error = "The date can not be higher than today";
            } else {
              error =
                  "Date cannot be later than ${DateFormat('dd/MM/yyyy').format(_maxDate)}";
            }
          }
        }
      } on FormatException {
        // error = LocaleKeys.validation_dateFormat.tr();
      }
    }

    return error;
  }
  
  @override
  String get type => "date_validator";
}
