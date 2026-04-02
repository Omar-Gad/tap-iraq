import 'package:flutter/widgets.dart';

abstract class AppNameValidator {
  static FormFieldValidator<String> get validate => (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Full name is required';
        }

        if (value.trim().length < 2) {
          return 'Name is too short';
        }

        return null;
      };
}
