import 'package:flutter/widgets.dart';

abstract class AppPhoneValidator {
  static FormFieldValidator<String> get validate => (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Phone is required';
        }

        final RegExp phoneRegex = RegExp(
          r'^[0-9]{10,15}$',
        );

        if (!phoneRegex.hasMatch(value.trim())) {
          return 'Invalid phone format (10-15 digits)';
        }

        return null;
      };
}
