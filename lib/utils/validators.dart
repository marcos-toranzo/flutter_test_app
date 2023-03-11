import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';

class PasswordValidator {
  final FormFieldValidator<String> validator;

  PasswordValidator.minLength({
    required int count,
    required String errorMessage,
  }) : validator = ((value) =>
            value != null && value.length >= count ? null : errorMessage);

  PasswordValidator.uppercaseCount({
    required int count,
    required String errorMessage,
  }) : validator = ((value) => _checkPattern(
              charactersToMatch: 'A-Z',
              count: count,
              value: value,
              errorMessage: errorMessage,
            ));

  PasswordValidator.lowercaseCount({
    required int count,
    required String errorMessage,
  }) : validator = ((value) => _checkPattern(
              charactersToMatch: 'a-z',
              count: count,
              value: value,
              errorMessage: errorMessage,
            ));

  PasswordValidator.numericCount({
    required int count,
    required String errorMessage,
  }) : validator = ((value) => _checkPattern(
              charactersToMatch: '0-9',
              count: count,
              value: value,
              errorMessage: errorMessage,
            ));

  PasswordValidator.specialCount({
    required int count,
    required String errorMessage,
  }) : validator = ((value) => _checkPattern(
              charactersToMatch: r"$&+,\:;/=?@#|'<>.^*()_%!-",
              count: count,
              value: value,
              errorMessage: errorMessage,
            ));

  static String? _checkPattern({
    required String charactersToMatch,
    required int count,
    required String? value,
    required String errorMessage,
  }) {
    if (value == null) return errorMessage;

    final pattern = '^(.*?[$charactersToMatch]){$count,}';
    return value.contains(RegExp(pattern)) ? null : errorMessage;
  }
}

class FormValidators {
  static FormFieldValidator<String> email(String errorMessage) {
    return (value) {
      if (value == null) return errorMessage;

      final regex = RegExp(
        r'(?:[a-z0-9!#$%&'
        r"'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"
        r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
      );

      return value == regex.stringMatch(value) ? null : errorMessage;
    };
  }

  static FormFieldValidator<String> required(String errorMessage) {
    return (value) => value?.isNotEmpty == true ? null : errorMessage;
  }

  static FormFieldValidator<String> password(
    List<PasswordValidator> validators,
  ) {
    return chain(validators.mapList((validator) => validator.validator));
  }

  static FormFieldValidator<String> chain(
    List<FormFieldValidator<String>> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }

      return null;
    };
  }
}
