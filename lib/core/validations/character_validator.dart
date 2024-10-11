// import 'package:form_validation/form_validation.dart';
// import 'package:static_translations/static_translations.dart';

// class CharacterValidator extends ValueValidator {
//   final String regex;
//   final String errorText;

//   CharacterValidator({required this.regex, required this.errorText});

//   CharacterValidator fromDynamic(dynamic map) {
//     CharacterValidator result = CharacterValidator(regex: "", errorText: "");

//     if (map != null) {
//       assert(map['type'] == type);

//       result = CharacterValidator(
//         regex: map['regex'],
//         errorText: map['errorText'],
//       );
//     }

//     return result;
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         // add additional attributes here
//         "type": type,
//       };

//   @override
//   String get type => "character_validator";

//   @override
//   String? validate({required String label, required String? value}) {
//     String? error;

//     // In general, validators should pass if the value is empty.  Combine
//     // validators with the RequiredValidator to ensure a value is non-empty.
//     if (value?.isNotEmpty == true) {
//       var regex = RegExp(this.regex);

//       if (!regex.hasMatch(value!)) {
//         error = errorText;
//       }
//     }

//     return error;
//   }
// }
