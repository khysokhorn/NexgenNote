import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RadiusTextField extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;
  final String hintText;
  final bool? isEnable;
  final bool autofocus;
  final bool obscureText;
  final Widget? prefixIcon;
  final bool? boldText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onSaved;
  final int? maxLine;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsets? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool? hideBorder;
  final double? hintTextFontSize;
  final String? initialValue;
  final int? errorMaxLines;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final String? suffixText;
  final double fontSize;
  final double borderWidth;

  // const RadiusTextField(
  //     {Key? key,
  //     this.focusNode,
  //     this.inputFormatters,
  //     this.autofocus = false,
  //     this.textInputType = TextInputType.emailAddress,
  //     this.isEnable = true,
  //     required this.textController,
  //     this.fillColor = Colors.white,
  //     this.obscureText = false,
  //     this.fontSize = 14,
  //     this.textColor = COLOR_GRAY,
  //     this.backgroundColor = COLOR_WHITE,
  //     this.labelColor = COLOR_GRAY,
  //     this.hintText = "",
  //     this.borderColor = COLOR_GRAY,
  //     this.prefixIcon,
  //     this.validator,
  //     this.onSaved,
  //     this.maxLine = 1,
  //     this.suffixIcon,
  //     this.onTap,
  //     this.onSubmitted,
  //     this.contentPadding,
  //     this.autovalidateMode,
  //     this.onChanged,
  //     this.maxLength,
  //     this.boldText,
  //     this.hideBorder,
  //     this.hintTextFontSize,
  //     this.initialValue,
  //     this.errorMaxLines,
  //     this.enableSuggestions = true,
  //     this.textCapitalization = TextCapitalization.sentences,
  //     this.readOnly = false,
  //     this.suffixText})
  //     : super(key: key);

  const RadiusTextField(
      {Key? key,
      this.focusNode,
      this.inputFormatters,
      this.autofocus = false,
      this.textInputType = TextInputType.emailAddress,
      this.isEnable = true,
      required this.textController,
      this.fillColor = Colors.white,
      this.obscureText = false,
      this.fontSize = 14,
      this.textColor = COLOR_GRAY,
      this.backgroundColor = COLOR_WHITE,
      this.labelColor = COLOR_GRAY,
      this.hintText = "",
      this.borderColor = COLOR_GRAY,
      this.prefixIcon,
      this.validator,
      this.onSaved,
      this.maxLine = 1,
      this.suffixIcon,
      this.onTap,
      this.onSubmitted,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 7.5),
      this.autovalidateMode,
      this.onChanged,
      this.maxLength,
      this.boldText,
      this.hideBorder,
      this.hintTextFontSize,
      this.initialValue,
      this.errorMaxLines,
      this.enableSuggestions = true,
      this.textCapitalization = TextCapitalization.sentences,
      this.readOnly = false,
      this.suffixText,
      this.borderWidth = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      initialValue: initialValue,
      controller: textController,
      enableSuggestions: enableSuggestions,
      focusNode: focusNode,
      keyboardType: textInputType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      onTap: onTap,
      maxLines: maxLine,
      style: TextStyle(
          color: textColor,
          fontWeight: boldText == true ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize),
      enabled: isEnable,
      autofocus: autofocus,
      validator: validator,
      keyboardAppearance: Brightness.dark,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onSaved: (value) {
        onSaved?.call(value);
      },
      maxLength: maxLength,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        // hintMaxLines:2,
        fillColor: backgroundColor,
        labelStyle: hintTextFontSize == null
            ? null
            : theme.bodyLarge!.copyWith(
                fontSize: hintTextFontSize!,
                color: COLOR_SURFACE_MEDIUM_EMPHASIS),
        hintStyle: hintTextFontSize == null
            ? null
            : theme.bodyLarge!.copyWith(
                fontSize: hintTextFontSize!,
                color: COLOR_SURFACE_MEDIUM_EMPHASIS),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: hintText,
        suffixText: suffixText,
        // labelText: textController.text == null ? hintText : null,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        errorMaxLines: errorMaxLines ?? 2,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.5),
        filled: true,
        counterText: "",
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: hideBorder == true ? Colors.transparent : borderColor,
              width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: hideBorder == true ? Colors.transparent : PRIMARY_COLOR,
              width: borderWidth),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: hideBorder == true ? Colors.transparent : borderColor,
              width: borderWidth),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: hideBorder == true ? Colors.transparent : borderColor,
              width: borderWidth),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: hideBorder == true ? Colors.transparent : COLOR_ERROR,
              width: borderWidth),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        // hintText: hintText,
      ),
    );
  }
}
