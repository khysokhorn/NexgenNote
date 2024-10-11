import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/ui/widgets/dynamic_form_builder_mixin.dart';
import 'package:noteapp/ui/widgets/radius_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utill/app_constants.dart';
import '../../generated/locale_keys.g.dart';

class FormTextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String? validatorText;
  final String? messageText;
  final TextInputType? textInputType;
  final bool? isRequired;
  final FormControlWidgetValidation? validation;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? isEnable;
  final bool? hideBorder;
  final bool? boldText;
  final Color? backgroundColor;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final double? hintFontSize;
  final ValueChanged<String>? onChanged;
  final bool? hasBottomPadding;
  final Widget? suffixIcon;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final Color? textColor;
  final int? errorMaxLines;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final bool multipleLines;
  final String?
      initialValue; // (RITM0078110) AL : init value on textField, add %
  final String? suffixText;

  const FormTextInputWidget({
    Key? key,
    required this.textController,
    this.hintText = '',
    this.validator,
    this.validatorText,
    this.messageText,
    this.textInputType,
    this.isRequired,
    this.validation,
    this.inputFormatters,
    this.maxLength,
    this.isEnable,
    this.boldText,
    this.backgroundColor = Colors.white,
    this.hideBorder,
    this.onSubmitted,
    this.onTap,
    this.hintFontSize,
    this.onChanged,
    this.hasBottomPadding = true,
    this.suffixIcon,
    this.obscureText = false,
    this.autovalidateMode,
    this.textColor,
    this.errorMaxLines,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.multipleLines = false,
    this.initialValue,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadiusTextField(
          autofocus: false,
          textInputType: multipleLines
              ? TextInputType.multiline
              : textInputType ?? TextInputType.text,
          enableSuggestions: enableSuggestions,
          textCapitalization: textCapitalization,
          borderColor: COLOR_GRAY,
          backgroundColor: backgroundColor ?? COLOR_WHITE,
          textController: textController,
          fillColor: COLOR_WHITE,
          hintText: hintText ?? '',
          isEnable: isEnable,
          hideBorder: hideBorder,
          boldText: boldText,
          labelColor: COLOR_GRAY,
          onSubmitted: onSubmitted,
          textColor: textColor ?? COLOR_GRAY,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 17.0),
          maxLine: multipleLines ? null : 1,
          onTap: onTap,
          maxLength: maxLength,
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          hintTextFontSize: hintFontSize,
          onChanged: onChanged,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
          errorMaxLines: errorMaxLines,
          initialValue: initialValue,
          suffixText: suffixText,
          validator: validator ??
              (String? value) {
                if (validation != null) {
                  return validation!.validate(value);
                }

                if ((value == null || value.isEmpty) && isRequired == true) {
                  return validatorText ?? LocaleKeys.provideCorrectInfo.tr();
                }
                return null;
              },
        ),
        if (hasBottomPadding == true)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 4,
            ),
            child: Text(
              messageText ?? "",
              style: theme.bodySmall!.copyWith(
                color: COLOR_SURFACE_MEDIUM_EMPHASIS,
              ),
            ),
          ),
      ],
    );
  }
}
