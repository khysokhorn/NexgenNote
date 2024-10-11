import 'package:form_validation/form_validation.dart';

import '../utill/regexes.dart';

class KhmerNameValidator extends ValueValidator {
  KhmerNameValidator fromDynamic(dynamic map) {
    KhmerNameValidator result = KhmerNameValidator();

    if (map != null) {
      assert(map['type'] == type);

      result = KhmerNameValidator(
          // Do additional JSON conversion here
          );
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
    required String label,
    required String? value,
  }) {
    String? error;

    // In general, validators should pass if the value is empty.  Combine
    // validators with the RequiredValidator to ensure a value is non-empty.
    if (value?.isNotEmpty == true) {
      // Do processing to determine if the value is valid or not
      if (!RegExp("^${RegExes.khmerCharacters.pattern}+\$").hasMatch(value!)) {
        // error = LocaleKeys.validation_khmerName.tr();
      }
    }

    return error;
  }

  @override
  // TODO: implement type
  String get type => "khmer_text_validator";
}
