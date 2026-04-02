import 'package:flutter/widgets.dart';

abstract class AppConfirmPasswordValidator {
  static FormFieldValidator<String> validate(String other) => (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }

        if (value != other) {
          return 'Passwords do not match';
        }

        return null;
      };
}
