import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

const descriptionKh = TextStyle(
  fontFamily: 'Battambong',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w400,
);

const subTitleKh = TextStyle(
  fontFamily: 'Battambong',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);

const titleKh = TextStyle(
  fontFamily: 'Battambong',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);

final outlineCardDecoration = BoxDecoration(
  color: COLOR_WHITE,
  borderRadius: const BorderRadius.all(
    Radius.circular(4),
  ),
  border: Border.all(
    width: 1.0,
    color: const Color.fromRGBO(0, 0, 0, 0.12),
  ),
);
