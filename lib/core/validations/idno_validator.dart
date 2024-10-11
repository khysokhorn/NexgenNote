// import 'package:form_validation/form_validation.dart';
// import 'package:static_translations/static_translations.dart';
// import 'package:easy_localization/easy_localization.dart';

// class IDNoValidator extends ValueValidator {
//   static const type = 'idno_validator';

//   final int maxLength = 20;

//   static IDNoValidator fromDynamic(dynamic map) {
//     IDNoValidator result = IDNoValidator();

//     if (map != null) {
//       assert(map['type'] == type);

//       result = IDNoValidator();
//     }

//     return result;
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         // add additional attributes here
//         "type": type,
//       };

//   @override
//   String? validate({
//     required String label,
//     required Translator translator,
//     required String? value,
//   }) {
//     String? error;

//     // In general, validators should pass if the value is empty.  Combine
//     // validators with the RequiredValidator to ensure a value is non-empty.
//     if (value?.isNotEmpty == true) {
//       // Do processing to determine if the value is valid or not
//       if (value!.length > maxLength) {
//         // error = LocaleKeys.text_provideCorrectInfo.tr();
//       } else if (!RegExp(r"^[a-zA-Z0-9\u1780-\u17FF\(\)]+$").hasMatch(value)) {
//         // error = LocaleKeys.text_provideCorrectInfo.tr();
//       }
//     }

//     return error;
//   }
// }
