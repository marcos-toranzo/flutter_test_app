import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/Validator.dart';

const _emailRegexPart1 = r'(?:[a-z0-9!#$%&';
const _emailRegexPart2 =
    r"'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|";
const _emailRegexPart3 =
    r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

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
  final PasswordValidationCheck? numericCharCountCheck;
  final PasswordValidationCheck? specialCharCountCheck;

  const PasswordValidationChecks({
    this.minLengthCheck,
    this.uppercaseCharCountCheck,
    this.numericCharCountCheck,
    this.specialCharCountCheck,
  });
}

class FormValidators {
  static FormFieldValidator<String> email(String errorMessage) {
    return (value) {
      if (value == null) return errorMessage;

      final regex = RegExp(
        _emailRegexPart1 + _emailRegexPart2 + _emailRegexPart3,
      );

      return value == regex.stringMatch(value) ? null : errorMessage;
    };
  }

  static FormFieldValidator<String> required(String errorMessage) {
    return (value) => value?.isNotEmpty == true ? null : errorMessage;
  }

  static FormFieldValidator<String> password(
    PasswordValidationChecks passwordValidationChecks,
  ) {
    return (value) {
      if (value == null) return null;

      final passwordValidator = Validator();

      final minLengthCheck = passwordValidationChecks.minLengthCheck;
      final uppercaseCharCountCheck =
          passwordValidationChecks.uppercaseCharCountCheck;
      final numericCharCountCheck =
          passwordValidationChecks.numericCharCountCheck;
      final specialCharCountCheck =
          passwordValidationChecks.specialCharCountCheck;

      if (minLengthCheck != null) {
        final isValid = passwordValidator.hasMinLength(
          value,
          minLengthCheck.count,
        );

        if (!isValid) {
          return minLengthCheck.errorMessage;
        }
      }
      if (uppercaseCharCountCheck != null) {
        final isValid = passwordValidator.hasMinUppercase(
          value,
          uppercaseCharCountCheck.count,
        );

        if (!isValid) {
          return uppercaseCharCountCheck.errorMessage;
        }
      }
      if (numericCharCountCheck != null) {
        final isValid = passwordValidator.hasMinNumericChar(
          value,
          numericCharCountCheck.count,
        );

        if (!isValid) {
          return numericCharCountCheck.errorMessage;
        }
      }
      if (specialCharCountCheck != null) {
        final isValid = passwordValidator.hasMinSpecialChar(
          value,
          specialCharCountCheck.count,
        );

        if (!isValid) {
          return specialCharCountCheck.errorMessage;
        }
      }

      return null;
    };
  }

  static FormFieldValidator<String> compose(
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
