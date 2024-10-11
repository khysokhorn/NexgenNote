import 'package:flutter/services.dart';
import 'package:form_validation/form_validation.dart';

class FormFieldInputOptions {
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;

  FormFieldInputOptions(this.inputType, this.inputFormatters);
}

/// Class for types of dynamic form controls
class FormControlType {
  static const String SECTION = "SECTION";
  static const String TEXT = "TEXT";
  static const String TEXTAREA = "TEXTAREA";
  static const String TEXT_NUMBER = "TEXT_NUMBER";
  static const String NUMBER = "NUMBER";
  static const String DECIMAL = "DECIMAL";
  static const String EMAIL = "EMAIL";
  static const String PHONE = "PHONE";
  static const String LOCATION = "LOCATION";
  static const String DATE = "DATE";
  static const String DATETIME = "DATETIME";
  static const String TIME = "TIME";
  static const String GENDER = "GENDER";
  static const String DROPDOWN = "DROPDOWN";
  static const String SINGLE_CHOICE = "SINGLE_CHOICE";
  static const String YES_NO = "YES_NO";
  static const String IMAGE_ATTACHMENT = "IMAGE_ATTACHMENT";
}

class ItemSourceName {
  static const String INDIVIDUAL_REVENUE = "INDIVIDUALREVENUE";
  static const String MARITAL_STATUS = "MARITAL_STATUS";
  static const String RESIDENCE = "RESIDENCE";
  static const String NATIONALITY = "NATIONALITY";
  static const String MARKETING_CHANNEL = "MARKETING_CHANNEL";
  static const String PREFERRED_COMMUNICATION = "PREFERRED_COMMUNICATION";
  static const String OCCUPATION = "OCCUPATION";
  static const String GENDER = "GENDER";
  static const String ID_TYPE = "ID_TYPE";
  static const String ALTERNATE_ID_TYPES = "ALTERNATE_ID_TYPES";
  static const String ACCOMMODATION_TYPE = "ACCOMMODATION_TYPE";
  static const String BUSINESS_TYPE = "BUSINESS_TYPE";
  static const String COMMUNE = "COMMUNE";
  static const String PROVINCE = "PROVINCE";
  static const String VILLAGE = "VILLAGE";
  static const String DISTRICT = "DISTRICT";
  static const String COUNTRY_OF_BIRTH = "COUNTRYOFBIRTH";
}

class RequiredPrimaryFieldName {
  static const String FIRST_NAME_EN = "firstNameEn";
  static const String LAST_NAME_EN = "lastNameEn";
}

class FormControlWidgetValidation {
  final Validator validator;
  final String label;

  FormControlWidgetValidation({
    required this.validator,
    required this.label,
  });

  validate(String? value) {
    return validator.validate(
      // context: GlobalService().context,
      label: label,
      value: value,
    );
  }
}
