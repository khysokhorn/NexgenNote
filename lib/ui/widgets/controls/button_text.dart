import 'package:flutter/material.dart';

import '../../../core/utill/colors.dart';

class ButtonText extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final InteractiveInkFeatureFactory splashFactory;
  final Color backgroundColor;
  final Color primary;
  const ButtonText(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.borderRadius = 5,
      this.padding = const EdgeInsets.all(10),
      this.backgroundColor = PRIMARY_COLOR,
      this.primary = COLOR_WHITE, this.splashFactory = NoSplash.splashFactory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: primary),
          child: child),
      style: TextButton.styleFrom(
        splashFactory: splashFactory,
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
    );
  }
}
