import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/views/home/book_category_preview.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/custom_drawer.dart';
import 'package:flutter_test_app/widgets/screen_with_loader.dart';

import '../../test_utils/mocks/data.dart';
import '../../test_utils/mocks/mock_flutter_app.dart';
import '../../test_utils/widget_finders.dart';

void main() {
  testWidgets('HomeScreen should have correct structure', (tester) async {
    await tester.pumpWidget(
      await initAndGetMockFlutterApp(const HomeScreen()),
    );
    await tester.pump(const Duration(seconds: 20));

    final findWidgetByType = findAndGetWidgetByType(find, tester);
    final findWidgetByKey = findAndGetWidgetByKey(find, tester);

    final CustomAppBar appBar = findWidgetByType();
    expect(appBar.titleText, 'Home');

    final ScreenWithLoader screenWithLoader = findWidgetByType();
    expect(screenWithLoader.drawer, isInstanceOf<CustomDrawer>());

    await tester.pump(const Duration(seconds: 20));

    final ListView listView =
        findWidgetByKey(const ValueKey('bookCategoriesListView'));

    final children =
        (listView.childrenDelegate as SliverChildListDelegate).children;
    expect(children.length, bookCategoriesResults.entries.length);

    for (var child in children) {
      expect(child, isInstanceOf<Padding>());

      final padding = child as Padding;
      expect(padding.child, isInstanceOf<BookCategoryPreview>());
    }

    findWidgetByKey<IconButton>(const ValueKey('cartButton'));
    findWidgetByKey<IconButton>(const ValueKey('refreshButton'));
  });
}
