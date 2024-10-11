import 'package:flutter/widgets.dart';

class FormRow2Widget extends StatelessWidget {
  final bool? hasPaddingTop;
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;

  const FormRow2Widget({
    Key? key,
    this.hasPaddingTop,
    required this.children,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: hasPaddingTop == true ? 13.5 : 0),
      child: Row(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: List.generate(
          children.length,
          (index) => Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.only(left: index > 0 ? 10 : 0),
              child: children[index],
            ),
          ),
        ),
      ),
    );
  }
}
