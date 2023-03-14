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

  int compareTo(Currency other) {
    return this > other ? 1 : (this < other ? -1 : 0);
  }

  bool operator >(Currency other) {
    return amount > other.amount;
  }

  bool operator <(Currency other) {
    return amount < other.amount;
  }

  bool operator >=(Currency other) {
    return amount >= other.amount;
  }

  bool operator <=(Currency other) {
    return amount <= other.amount;
  }

  static const String defaultCode = 'EUR';
}
