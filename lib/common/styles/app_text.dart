import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppText {
  static double get _textScale {
    final context = Get.context;
    return context != null ? context.textScaleFactor : 1.0;
  }

  static TextStyle headlineMedium = TextStyle(
    fontSize: 24 * _textScale,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleLarge = TextStyle(
    fontSize: 22 * _textScale,
    fontWeight: FontWeight.w600,
  );
  static TextStyle titleMedium = TextStyle(
    fontSize: 20 * _textScale,
    fontWeight: FontWeight.w500,
  );
  static TextStyle titleSmall = TextStyle(
    fontSize: 18 * _textScale,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16 * _textScale,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14 * _textScale,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 14 * _textScale,
    fontWeight: FontWeight.w400,
  );
}
