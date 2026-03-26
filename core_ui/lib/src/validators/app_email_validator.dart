import 'package:flutter/widgets.dart';

class AppEmailValidator {
  static FormFieldValidator<String> get validate => (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email is required';
        }

        final RegExp emailRegex = RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
        );

        if (!emailRegex.hasMatch(value.trim())) {
          return 'Invalid email format';
        }

        return null;
      };
}
