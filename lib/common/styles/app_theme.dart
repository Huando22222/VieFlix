import 'package:flutter/material.dart';
import 'package:vie_flix/common/styles/app_color.dart';
import 'package:vie_flix/common/styles/app_text.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      titleTextStyle:
          AppText.headlineMedium.copyWith(color: AppColor.lightPrimary),
    ),
    colorScheme: const ColorScheme.light(
        surface: AppColor.lightBackground,
        primary: AppColor.lightPrimary,
        secondary: AppColor.lightSecondary,
        onSurface: AppColor.lightAccent),
    textTheme: TextTheme(
      headlineMedium:
          AppText.headlineMedium.copyWith(color: AppColor.lightText),
      titleLarge: AppText.titleLarge.copyWith(color: AppColor.lightText),
      titleMedium: AppText.titleMedium.copyWith(color: AppColor.lightPrimary),
      titleSmall: AppText.titleSmall.copyWith(color: AppColor.lightSecondary),
      bodyLarge: AppText.bodyLarge.copyWith(color: AppColor.lightText),
      bodyMedium: AppText.bodyMedium.copyWith(color: AppColor.lightText),
      bodySmall: AppText.bodySmall.copyWith(
        color: AppColor.lightText.withOpacity(0.8),
      ),
    ),
    scaffoldBackgroundColor: AppColor.lightBackground,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      titleTextStyle:
          AppText.headlineMedium.copyWith(color: AppColor.darkPrimary),
    ),
    colorScheme: const ColorScheme.dark(
      surface: AppColor.darkBackground,
      primary: AppColor.darkPrimary,
      secondary: AppColor.darkSecondary,
      onSurface: AppColor.darkAccent,
    ),
    textTheme: TextTheme(
      headlineMedium: AppText.headlineMedium.copyWith(color: AppColor.darkText),
      titleLarge: AppText.titleLarge.copyWith(color: AppColor.darkText),
      titleMedium: AppText.titleMedium.copyWith(color: AppColor.darkPrimary),
      titleSmall: AppText.titleSmall.copyWith(color: AppColor.darkSecondary),
      bodyLarge: AppText.bodyLarge.copyWith(color: AppColor.darkText),
      bodyMedium: AppText.bodyMedium.copyWith(color: AppColor.darkText),
      bodySmall: AppText.bodySmall.copyWith(
        color: AppColor.darkText.withOpacity(0.8),
      ),
    ),
    scaffoldBackgroundColor: AppColor.darkBackground,
  );
}
