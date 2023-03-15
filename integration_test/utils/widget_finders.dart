import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

T Function<T>({bool skipOffstage}) findAndGetWidgetByType<T>(
    CommonFinders find, WidgetTester tester) {
  return <T>({bool skipOffstage = true}) {
    final widgetFinder = find.byType(T, skipOffstage: skipOffstage);
    expect(widgetFinder, findsOneWidget);
    return tester.widget(widgetFinder) as T;
  };
}

List<T> Function<T>(Matcher, {bool skipOffstage}) findAndGetWidgetsByType<T>(
    CommonFinders find, WidgetTester tester) {
  return <T>(Matcher matcher, {bool skipOffstage = true}) {
    final widgetFinder = find.byType(T, skipOffstage: skipOffstage);
    expect(widgetFinder, matcher);
    return tester.widgetList(widgetFinder) as List<T>;
  };
}

T Function<T>(Key, {bool skipOffstage}) findAndGetWidgetByKey<T>(
  CommonFinders find,
  WidgetTester tester,
) {
  return <T>(key, {bool skipOffstage = true}) {
    final widgetFinder = find.byKey(key, skipOffstage: skipOffstage);
    expect(widgetFinder, findsOneWidget);
    return tester.widget(widgetFinder) as T;
  };
}

List<T> Function<T>(Key, Matcher, {bool skipOffstage})
    findAndGetWidgetsByKey<T>(
  CommonFinders find,
  WidgetTester tester,
) {
  return <T>(key, matcher, {bool skipOffstage = true}) {
    final widgetFinder = find.byKey(key, skipOffstage: skipOffstage);
    expect(widgetFinder, matcher);
    return tester.widgetList(widgetFinder) as List<T>;
  };
}
