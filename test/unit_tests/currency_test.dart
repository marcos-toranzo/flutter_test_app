import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/utils/currency.dart';

void main() {
  const currency1 = Currency(amount: 10, code: 'EUR');
  const currency2 = Currency(amount: 2, code: 'EUR');
  const currency3 = Currency(amount: 10, code: 'EUR');

  test('Currency should be bigger', () {
    expect(currency1 > currency2, true);
  });

  test('Currency should be bigger or equal', () {
    expect(currency1 >= currency3, true);
  });

  test('Currency should be smaller', () {
    expect(currency2 < currency1, true);
  });

  test('Currency should be smaller or equal', () {
    expect(currency1 <= currency3, true);
  });
}
