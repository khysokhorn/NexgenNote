import 'package:flutter/material.dart';

import '../../../core/utill/colors.dart';

class ButtonOutline extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  const ButtonOutline({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 5,
    this.borderColor = PRIMARY_COLOR,
    this.borderWidth = 1,
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: IconTheme(
        data: const IconThemeData(color: PRIMARY_COLOR),
        child: DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: PRIMARY_COLOR),
            child: child),
      ),
      style: OutlinedButton.styleFrom(
          padding: padding,
          side: BorderSide(width: borderWidth, color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
    );
  }
}
