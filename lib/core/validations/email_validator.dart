import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';

class EmailValidator extends JsonClass implements ValueValidator {
  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A `null`
  /// value will result in a return value of `null`.
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "type": "email"
  /// }
  /// ```
  EmailValidator fromDynamic(dynamic map) {
    EmailValidator result;

    if (map == null) {
      throw Exception('[EmailValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == type);

      result = EmailValidator();
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'type': type,
      };

  /// Ensures the value is formatted as a valid email address.
  ///
  /// This will pass on empty or `null` values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_email]
  @override
  String? validate({
    required String label,
    required String? value,
  }) {
    String? error;

    if (value?.isNotEmpty == true) {
      // Credit to this SO answer: https://stackoverflow.com/a/16888554
      var pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)+$";

      var regExp = RegExp(pattern);

      if (!regExp.hasMatch(value ?? '')) {
        // error = LocaleKeys.text_provideCorrectInfo.tr();
      }
    }

    return error;
  }

  @override
  String get type => "email_validator";
}
