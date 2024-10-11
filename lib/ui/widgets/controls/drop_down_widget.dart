import 'package:flutter/material.dart';

import '../../../core/utill/colors.dart';

class DropDownWidget extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final String hint;
  final dynamic value;
  final FormFieldValidator<dynamic>? validator;
  final String? secondHint;
  final EdgeInsets? contentPadding;
  final void Function(dynamic)? onChanged;
  final bool? isEnabled;
  final Color? backgroundColor;
  final AutovalidateMode? autovalidateMode;

  const DropDownWidget({
    Key? key,
    required this.items,
    required this.hint,
    this.onChanged,
    this.validator,
    this.secondHint,
    this.contentPadding,
    required this.value,
    this.isEnabled,
    this.backgroundColor,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4.0))
      ),
      child: DropdownButtonFormField<dynamic>(
        icon: const Icon(Icons.expand_more),
        decoration: InputDecoration(
          hintText: value == null ? hint : null,
          labelText: value != null ? hint : null,
          contentPadding: contentPadding ?? const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: COLOR_ERROR, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
        isExpanded: true,
        iconSize: isEnabled == true ? 24.0 : 0,
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: autovalidateMode,
      ),
    );
  }
}
