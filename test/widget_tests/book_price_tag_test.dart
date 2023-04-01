import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/widgets/book/book_price_tag.dart';

import '../../test_utils/mocks/mock_flutter_app.dart';
import '../../test_utils/widget_finders.dart';

void main() {
  testWidgets('BookPriceTag should show price', (tester) async {
    const price = Currency(amount: 20.43, code: 'EUR');

    await tester.pumpWidget(
      await initAndGetMockFlutterApp(
        const BookPriceTag(
          price: price,
          saleability: BookSaleability.forSale,
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);

    final Chip chip = findWidgetByType();

    expect(chip.label, isInstanceOf<Text>());

    final text = chip.label as Text;

    expect(text.data, price.format());
  });

  testWidgets('BookPriceTag should show FREE', (tester) async {
    await tester.pumpWidget(
      await initAndGetMockFlutterApp(
        const BookPriceTag(
          price: null,
          saleability: BookSaleability.free,
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);

    final Chip chip = findWidgetByType();

    expect(chip.label, isInstanceOf<Text>());

    final text = chip.label as Text;

    expect(text.data, 'FREE');
  });

  testWidgets('BookPriceTag should show NOT FOR SALE', (tester) async {
    await tester.pumpWidget(
      await initAndGetMockFlutterApp(
        const BookPriceTag(
          price: null,
          saleability: BookSaleability.notForSale,
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);

    final Chip chip = findWidgetByType();

    expect(chip.label, isInstanceOf<Text>());

    final text = chip.label as Text;

    expect(text.data, 'NOT FOR SALE');
  });
}
