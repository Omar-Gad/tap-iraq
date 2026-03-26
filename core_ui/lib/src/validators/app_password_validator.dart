import 'package:flutter/widgets.dart';

class AppPasswordValidator {
  static FormFieldValidator<String> get validate => (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Password is required';
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }

        return null;
      };
}
