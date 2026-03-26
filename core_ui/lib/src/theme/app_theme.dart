import 'package:flutter/material.dart';

import '../../core_ui.dart';

const LightColors _appColors = LightColors();

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: _appColors.neutral[50],
  appBarTheme: _getAppBarTheme(),
  textTheme: _getTextTheme(),
  inputDecorationTheme: _getInputDecorationTheme(),
  primaryColor: _appColors.primary[500],
  disabledColor: _appColors.neutral[300],
  colorScheme: ColorScheme.light(
    primary: _appColors.primary[500]!,
    secondary: _appColors.secondary[500]!,
    tertiary: _appColors.tertiary[500]!,
    surface: _appColors.neutral[50]!,
  ),
);

TextTheme _getTextTheme() {
  return TextTheme(
    titleMedium: AppFonts.normal13,
    bodyMedium: AppFonts.normal13,
  ).apply(
    bodyColor: _appColors.primary[900],
    displayColor: _appColors.primary[900],
  );
}

InputDecorationTheme _getInputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: AppFonts.normal13.copyWith(color: _appColors.neutral[400]),
    filled: true,
    fillColor: _appColors.neutral[100],
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: _appColors.neutral[300]!,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: _appColors.neutral[300]!,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: _appColors.primary[500]!,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    labelStyle: AppFonts.normal13.copyWith(color: _appColors.primary[600]),
  );
}

AppBarTheme _getAppBarTheme() {
  return AppBarTheme(
    backgroundColor: _appColors.neutral[50],
    elevation: 0,
    iconTheme: IconThemeData(color: _appColors.primary[900]),
    titleTextStyle: AppFonts.normal18.copyWith(
      color: _appColors.primary[900],
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  );
}
