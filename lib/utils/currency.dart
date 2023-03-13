import 'package:intl/intl.dart';

class Currency {
  final double amount;
  final String code;

  const Currency({required this.amount, required this.code});

  const Currency.zero()
      : amount = 0,
        code = Currency.defaultCode;

  String format([int decimalDigits = 2]) {
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: decimalDigits,
      name: code,
    );

    return formatter.format(amount);
  }

  static const String defaultCode = 'EUR';
}
