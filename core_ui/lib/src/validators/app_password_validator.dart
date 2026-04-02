import 'package:flutter/widgets.dart';

abstract class AppPasswordValidator {
  static FormFieldValidator<String> get validate => (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }

        if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password must contain at least one number';
        }

        return null;
      };
}

