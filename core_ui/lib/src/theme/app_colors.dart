import 'package:flutter/material.dart';

abstract class AppColors {
  factory AppColors.of(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const LightColors()
        : const DarkColors();
  }

  MaterialColor get primary;
  MaterialColor get secondary;
  MaterialColor get tertiary;
  MaterialColor get neutral;
  Color get white;
  Color get black;
}

class DarkColors extends LightColors {
  const DarkColors();
}

class LightColors implements AppColors {
  const LightColors();

  @override
  MaterialColor get primary => _buildMaterialColor(const Color(0xFF1A2F45));

  @override
  MaterialColor get secondary => _buildMaterialColor(const Color(0xFF5B7C99));

  @override
  MaterialColor get tertiary => _buildMaterialColor(const Color(0xFF4A9B8E));

  @override
  MaterialColor get neutral => _buildMaterialColor(const Color(0xFFF5F5F5));

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get black => const Color(0xFF000000);
}

MaterialColor _buildMaterialColor(Color color) {
  Map<int, Color> colorMap = {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  };
  return MaterialColor(color.value, colorMap);
}

int _tintValue(int value, double factor) =>
    (value + ((255 - value) * factor)).round();

Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1,
    );

int _shadeValue(int value, double factor) => (value * (1.0 - factor)).round();

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1,
    );
