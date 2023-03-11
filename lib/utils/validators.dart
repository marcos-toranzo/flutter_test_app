import 'package:flutter/material.dart';

class PasswordValidationCheck {
  final int count;
  final String errorMessage;

  const PasswordValidationCheck({
    required this.count,
    required this.errorMessage,
  });
}

class PasswordValidationChecks {
  final PasswordValidationCheck? minLengthCheck;
  final PasswordValidationCheck? uppercaseCharCountCheck;
  final PasswordValidationCheck? lowercaseCharCountCheck;
  final PasswordValidationCheck? numericCharCountCheck;
  final PasswordValidationCheck? specialCharCountCheck;

  const PasswordValidationChecks({
    this.minLengthCheck,
    this.uppercaseCharCountCheck,
    this.lowercaseCharCountCheck,
    this.numericCharCountCheck,
    this.specialCharCountCheck,
  });
}

class PasswordValidators {
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

  static FormFieldValidator<String> minLength({
    required count,
    required errorMessage,
  }) =>
      (value) => value != null && value.length >= count ? null : errorMessage;

  static FormFieldValidator<String> uppercaseCount({
    required count,
    required errorMessage,
  }) =>
      (value) => _checkPattern(
            charactersToMatch: 'A-Z',
            count: count,
            value: value,
            errorMessage: errorMessage,
          );

  static FormFieldValidator<String> lowercaseCount({
    required count,
    required errorMessage,
  }) =>
      (value) => _checkPattern(
            charactersToMatch: 'a-z',
            count: count,
            value: value,
            errorMessage: errorMessage,
          );

  static FormFieldValidator<String> numericCount({
    required count,
    required errorMessage,
  }) =>
      (value) => _checkPattern(
            charactersToMatch: '0-9',
            count: count,
            value: value,
            errorMessage: errorMessage,
          );

  static FormFieldValidator<String> specialCount({
    required count,
    required errorMessage,
  }) =>
      (value) => _checkPattern(
            charactersToMatch: r"$&+,\:;/=?@#|'<>.^*()_%!-",
            count: count,
            value: value,
            errorMessage: errorMessage,
          );
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
    PasswordValidationChecks checks,
  ) {
    final minLengthCheck = checks.minLengthCheck;
    final uppercaseCharCountCheck = checks.uppercaseCharCountCheck;
    final lowercaseCharCountCheck = checks.lowercaseCharCountCheck;
    final numericCharCountCheck = checks.numericCharCountCheck;
    final specialCharCountCheck = checks.specialCharCountCheck;

    final List<FormFieldValidator<String>> validators = [
      if (minLengthCheck != null)
        PasswordValidators.minLength(
          count: minLengthCheck.count,
          errorMessage: minLengthCheck.errorMessage,
        ),
      if (uppercaseCharCountCheck != null)
        PasswordValidators.uppercaseCount(
          count: uppercaseCharCountCheck.count,
          errorMessage: uppercaseCharCountCheck.errorMessage,
        ),
      if (lowercaseCharCountCheck != null)
        PasswordValidators.lowercaseCount(
          count: lowercaseCharCountCheck.count,
          errorMessage: lowercaseCharCountCheck.errorMessage,
        ),
      if (numericCharCountCheck != null)
        PasswordValidators.numericCount(
          count: numericCharCountCheck.count,
          errorMessage: numericCharCountCheck.errorMessage,
        ),
      if (specialCharCountCheck != null)
        PasswordValidators.specialCount(
          count: specialCharCountCheck.count,
          errorMessage: specialCharCountCheck.errorMessage,
        ),
    ];

    return chain(validators);
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
