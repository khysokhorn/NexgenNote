import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/utill/dimensions.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? title;
  final IconData? leftIcon;
  final String? leftImagePath;
  final Color? leftIconColor;
  final double? leftIconSize;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.child,
    this.title,
    this.leftIcon,
    this.leftImagePath,
    this.leftIconColor,
    this.leftIconSize = 18,
  }) : super(key: key);

  Widget _buildLeftIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 9,
      ),
      child: leftIcon != null
          ? Icon(
              leftIcon,
              color: leftIconColor ?? Colors.white,
            )
          : Image.asset(
              leftImagePath!,
              width: leftIconSize ?? 18,
              height: leftIconSize ?? 18,
              color: leftIconColor ?? Colors.white,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: width != null && height != null
            ? Size(width!, height!)
            : Size.fromHeight(height ?? Dimensions.BUTTON_HEIGHT),
        padding: padding ??
            const EdgeInsets.only(
              left: 14,
              right: 14,
            ),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: onPressed,
      child: child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leftIcon != null || leftImagePath != null)
                _buildLeftIcon(context),
              Flexible(
                fit: FlexFit.loose,
                child: AutoSizeText(
                  title != null ? title!.toUpperCase() : "",
                  maxLines: 1,
                  minFontSize: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: textColor ?? Colors.white),
                ),
              ),
            ],
          ),
    );
  }
}

class ButtonOutlineWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? title;
  final IconData? leftIcon;
  final String? leftImagePath;
  final Color? leftIconColor;
  final double? leftIconSize;

  const ButtonOutlineWidget({
    Key? key,
    required this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.child,
    this.title,
    this.leftIcon,
    this.leftImagePath,
    this.leftIconColor,
    this.leftIconSize = 18,
  }) : super(key: key);

  Widget _buildLeftIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: leftIcon != null
          ? Icon(
              leftIcon,
              color: leftIconColor ?? PRIMARY_COLOR,
            )
          : Image.asset(
              leftImagePath!,
              width: leftIconSize ?? 18,
              height: leftIconSize ?? 18,
              color: leftIconColor ?? PRIMARY_COLOR,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: width != null && height != null
            ? Size(width!, height!)
            : Size.fromHeight(height ?? Dimensions.BUTTON_HEIGHT),
        padding: padding ??
            const EdgeInsets.only(
              left: 14,
              right: 14,
            ),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: borderColor ?? PRIMARY_COLOR,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leftIcon != null || leftImagePath != null)
                _buildLeftIcon(context),
              Flexible(
                fit: FlexFit.loose,
                child: AutoSizeText(
                  title != null ? title!.toUpperCase() : "",
                  maxLines: 1,
                  minFontSize: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: textColor ?? PRIMARY_COLOR),
                ),
              ),
            ],
          ),
    );
  }
}
