import 'package:flutter/material.dart';

import '../../../core/utill/colors.dart';

class ButtonBorderWidget extends StatelessWidget {
  final Function onClick;
  final Widget child;
  final double height;
  final double? width;
  final double borderRadius;
  final Color color;
  final Color borderColor;

  const ButtonBorderWidget({
    Key? key,
    required this.onClick,
    this.child = const Text("Button text"),
    this.height = 53,
    this.width,
    this.borderRadius = 10.0,
    this.color = Colors.greenAccent,
    this.borderColor = COLOR_GREY,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // width: width,
      child: OutlinedButton(
        child: DefaultTextStyle(
          style: TextStyle(
            color: color,
          ),
          child: child,
        ),
        onPressed: () => onClick(),
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
        // borderSide: const BorderSide(color: COLOR_GREY),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(borderRadius),
        // ),
      ),
    );
  }
}
