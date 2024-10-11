import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class FormDropdownWidgetData {
  final dynamic value;
  final dynamic parentValue;
  final String? text;
  final Map<String, dynamic>? extraData;

  FormDropdownWidgetData(this.value, this.text,
      [this.parentValue, this.extraData]);

  FormDropdownWidgetData.blank() : this("", "", "", {});

  @override
  String toString() {
    return text ?? '';
  }
}

/// Controller for FormDropdownWidget
class FormDropdownController extends ValueNotifier<dynamic> {
  final List<String> parentFieldNames = [];
  dynamic _parentValue;
  bool isHidden = false;

  FormDropdownController([dynamic value]) : super(value);

  dynamic get parentValue => _parentValue;
  set parentValue(value) {
    _parentValue = value;
    notifyListeners();
  }

  void clear() {
    value = null;
  }

  bool dependsOnField(String parentFieldName) {
    return parentFieldNames.contains(parentFieldName);
  }

  void setHidden(bool isHidden) {
    this.isHidden = isHidden;
    notifyListeners();
  }
}

class FormDropdownWidget extends StatefulWidget {
  final String title;
  final void Function(FormDropdownWidgetData)? onChanged;
  final FormFieldValidator<FormDropdownWidgetData>? validator;
  final String? validatorText;
  final int? length;
  final FormDropdownWidgetData? Function(int)? getData;
  final FormDropdownWidgetData? Function(dynamic value)? getInitialSelectedData;
  final List<FormDropdownWidgetData> Function()? getDataList;
  final Future<List<FormDropdownWidgetData>> Function()? getDataListAsync;
  final dynamic value;
  final FormDropdownController? controller;
  final bool? isRequired;
  final bool? showSearchBox;
  //final FormControlWidgetValidation? validation;
  final bool? hasBottomPadding;
  final bool? hidden;
  final double? hintFontSize;
  final bool? isEnabled;
  final Color? backgroundColor;
  final double? width;
  final AutovalidateMode? autovalidateMode;
  final bool? hideBorder;
  final Color? borderColor;
  final bool enableClearButton;
  final EdgeInsets? contentPadding;
  final Function? onClearPressed;

  const FormDropdownWidget({
    Key? key,
    this.title = '',
    this.length,
    this.getData,
    this.getDataList,
    this.onChanged,
    this.validator,
    this.validatorText,
    this.value,
    this.controller,
    this.getInitialSelectedData,
    this.isRequired,
    //this.validation,
    this.showSearchBox,
    this.hasBottomPadding = true,
    this.hidden,
    this.hintFontSize,
    this.isEnabled = true,
    this.backgroundColor,
    this.width,
    this.getDataListAsync,
    this.autovalidateMode,
    this.hideBorder,
    this.borderColor = COLOR_GRAY,
    this.enableClearButton = false,
    this.contentPadding = const EdgeInsets.fromLTRB(12, 0, 0, 20),
    this.onClearPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormDropdownWidgetState();
  }
}

class _FormDropdownWidgetState extends State<FormDropdownWidget> {
  dynamic value;

  @override
  initState() {
    super.initState();
    value = widget.controller?.value ?? value;
    widget.controller?.addListener(_notifyChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_notifyChange);
  }

  _notifyChange() {
    if (mounted) {
      setState(() {
        value = widget.controller?.value;
        //  GlobalFunction.printDebugMessage("Changed: $value");
      });
    }
  }

  Future<List<FormDropdownWidgetData>> getDataItem(String? filter) async {
    List<FormDropdownWidgetData> results = [];

    if (widget.getDataList != null) {
      var dataList = widget.getDataList!();

      for (var i = 0; i < dataList.length; i++) {
        var data = dataList[i];

        if (filter == null || filter.isEmpty || data.text!.contains(filter)) {
          results.add(data);
        }
      }

      await Future.delayed(const Duration(milliseconds: 200));
    } else if (widget.length != null && widget.getData != null) {
      for (var i = 0; i < widget.length!; i++) {
        var data = widget.getData!(i);

        if (data == null) {
          continue;
        }

        if (filter == null || filter.isEmpty || data.text!.contains(filter)) {
          results.add(data);
        }
      }

      await Future.delayed(const Duration(milliseconds: 200));
    } else if (widget.getDataListAsync != null) {
      var dataList = await widget.getDataListAsync!();

      for (var i = 0; i < dataList.length; i++) {
        var data = dataList[i];

        if (filter == null || filter.isEmpty || data.text!.contains(filter)) {
          results.add(data);
        }
      }

      await Future.delayed(const Duration(milliseconds: 200));
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden == true || widget.controller?.isHidden == true) {
      return const SizedBox();
    }

    final selectedValue = widget.getInitialSelectedData?.call(value);
    final hasValue = selectedValue?.value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          child: DropdownSearch<FormDropdownWidgetData>(
            autoValidateMode:
                widget.autovalidateMode ?? AutovalidateMode.disabled,
            selectedItem: selectedValue,
            enabled: widget.isEnabled == true,
            // dropdownButtonBuilder:
            //     widget.isEnabled == true ? null : (context) => const SizedBox(),
            // Dropdown box

            onChanged: (FormDropdownWidgetData? data) {
              GlobalFunction.printDebugMessage(
                  "Select value: ${data?.value}, ${data?.parentValue}");
              widget.controller?.value = data?.value;
              widget.controller?.parentValue = data?.parentValue;
              widget.onChanged?.call(data ?? FormDropdownWidgetData.blank());
            },
            // Search box
            // searchFieldProps: TextFieldProps(
            //   style: theme.bodyText1!.copyWith(color: PRIMARY_COLOR),
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: const Color(0xFFF2F2F2),
            //     hintText: LocaleKeys.search.tr(),
            //     labelStyle: theme.bodyText1!
            //         .copyWith(color: COLOR_SURFACE_MEDIUM_EMPHASIS),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            //   padding: const EdgeInsets.only(
            //       left: 16, top: 16, right: 16, bottom: 8),
            // ),
            // showSearchBox: widget.showSearchBox ?? true,
            // validator: (value) {
            //   if (widget.validator != null) {
            //     return widget.validator?.call(value);
            //   }

            //   if (widget.validation != null) {
            //     return widget.validation!.validate(value?.text);
            //   }

            //   if (value == null && widget.isRequired == true) {
            //     return widget.validatorText ??
            //         LocaleKeys.text_provideCorrectInfo.tr();
            //   }
            //   return null;
            // },
          ),
        ),
        if (widget.hasBottomPadding == true) const SizedBox(height: 18),
      ],
    );
  }
}
