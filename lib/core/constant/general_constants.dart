import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

enum Currency { usd, khr }

Color textPrimaryColor = Colors.black87.withOpacity(0.65);
Color textSecondaryColor = Colors.black54;

// State Icons
const IconData successIcon = HugeIcons.strokeRoundedCheckmarkBadge01;
const IconData dangerIcon = HugeIcons.strokeRoundedCancelCircle;
const IconData warningIcon = HugeIcons.strokeRoundedAlert02;
const IconData infoIcon = HugeIcons.strokeRoundedInformationCircle;

const EdgeInsets allPadding = const EdgeInsets.all(8.0);

// Border Radius
BorderRadius borderRadius = BorderRadius.circular(8.0);
BorderRadius topRadius = BorderRadius.vertical(
  top: Radius.circular(16.0),
);

// Primary color
MaterialColor seedColorPalette = MaterialColor(
  seedColor.value,
  const <int, Color>{
    50: Color(0xFFD9E7FD),
    100: Color(0xFFC0D6FB),
    200: Color(0xFFA0C2FA),
    300: Color(0xFF81AEF8),
    400: Color(0xFF6299F6),
    500: Color(0xFF376FCB),
    600: Color(0xFF2C59A3),
    700: Color(0xFF21427A),
    800: Color(0xFF162C51),
    900: Color(0xFF0D1B31),
  },
);

// Colors
const Color seedColor = Color(0xFF4285F4);

// Neutrals
const Color darkColor = Color(0xFF0C0C0C);
const Color backgroundColor = Color(0xFF030326);
const Color scaffoldBgColor = Color(0xFFF6F5F4);
const Color disabledColor = Color(0xFF8D8D8D);

// Filters
ImageFilter blurFilter = ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0);

// State Colors
const Color successColor = Color(0xFF0F9D58);
const Color dangerColor = Color(0xFFDB4437);
const Color warningColor = Color(0xFFF4B400);
const Color infoColor = Color(0xFF6424EC);

// TextStyles
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 34.0,
    height: 40.0 / 34.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 28.0,
    height: 36.0 / 28.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24.0,
    height: 32.0 / 24.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20.0,
    height: 28.0 / 20.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18.0,
    height: 24.0 / 18.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    height: 24.0 / 16.0,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle small = TextStyle(
    fontSize: 12.0,
    height: 16.0 / 12.0,
    fontWeight: FontWeight.normal,
  );
}

// Duration
const Duration duration = Duration(milliseconds: 300);

// Input borders
class AppInputBorders {
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1.5,
    ),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: seedColor,
      width: 1.5,
    ),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: dangerColor,
      width: 1.5,
    ),
  );

  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: dangerColor,
      width: 1.5,
    ),
  );

  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1.5,
    ),
  );

  static OutlineInputBorder disabledBorder = OutlineInputBorder(
    borderRadius: borderRadius * 2,
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1.5,
    ),
  );
}

// Media sizes
double mediaWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

double mediaHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

// Shadow
BoxShadow shadow = BoxShadow(
  color: Colors.black.withOpacity(0.08),
  blurRadius: 8.0,
  offset: Offset(0, 2),
);

// Decoration
BoxDecoration formFieldDecoration = BoxDecoration(
  borderRadius: borderRadius * 2,
  color: Colors.white,
  boxShadow: [shadow],
);
