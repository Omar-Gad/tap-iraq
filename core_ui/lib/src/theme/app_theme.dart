import 'package:flutter/material.dart';

import '../../core_ui.dart';

const LightColors _appColors = LightColors();

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: _appColors.white,
  appBarTheme: _getAppBarTheme(),
  textTheme: _getTextTheme(),
  inputDecorationTheme: _getInputDecorationTheme(),
  primaryColor: _appColors.primary[500],
  disabledColor: _appColors.neutral[500],
  colorScheme: ColorScheme.light(
    primary: _appColors.primary[500]!,
    secondary: _appColors.secondary[500]!,
    tertiary: _appColors.tertiary[500]!,
    surface: _appColors.white,
  ),
);

TextTheme _getTextTheme() {
  return TextTheme(
    titleMedium: AppFonts.normal13,
    bodyMedium: AppFonts.normal13,
  ).apply(
    bodyColor: _appColors.primary[500],
    displayColor: _appColors.primary[500],
  );
}

InputDecorationTheme _getInputDecorationTheme() {
  return InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: _appColors.neutral[500],
    hintStyle: AppFonts.normal14.copyWith(
      color: _appColors.primary[500]!.withOpacity(0.4),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 18.0,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: _appColors.tertiary[500]!,
        width: 1.5,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
    ),
  );
}

AppBarTheme _getAppBarTheme() {
  return AppBarTheme(
    backgroundColor: _appColors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: _appColors.primary[500]),
    titleTextStyle: AppFonts.normal18.copyWith(
      color: _appColors.primary[500],
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  );
}
