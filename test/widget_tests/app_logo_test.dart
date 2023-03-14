import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/widgets/app_logo.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/space.dart';

void main() {
  testWidgets('AppLogo should not show text', (tester) async {
    await tester.pumpWidget(_getAppLogo(size: 100, includeText: false));

    final textFinder = find.text('Mobile App');

    expect(textFinder, findsNothing);
  });

  testWidgets('AppLogo should show text', (tester) async {
    await tester.pumpWidget(_getAppLogo(size: 100));

    final textFinder = find.text('Mobile App');

    expect(textFinder, findsOneWidget);
  });

  testWidgets('AppLogo should show correct image', (tester) async {
    const size = 100.0;

    await tester.pumpWidget(_getAppLogo(size: size));

    final svgPictureFinder = find.byType(SvgPicture);

    expect(svgPictureFinder, findsOneWidget);

    final svgPicture = tester.widget(svgPictureFinder) as SvgPicture;

    expect(svgPicture.pictureProvider is ExactAssetPicture, true);
    expect(
      (svgPicture.pictureProvider as ExactAssetPicture).assetName ==
          'assets/images/app_logo.svg',
      true,
    );
    expect(svgPicture.height, size);
    expect(svgPicture.width, size);
  });

  testWidgets('AppLogo should show correct structure', (tester) async {
    const size = 100.0;

    await tester.pumpWidget(_getAppLogo(size: size));

    final columnFinder = find.byType(Column);

    expect(columnFinder, findsOneWidget);

    final column = tester.widget(columnFinder) as Column;

    expect(column.children.length, 3);

    expect(column.children[0] is SvgPicture, true);
    expect(column.children[1] is Space, true);
    expect(column.children[2] is OnBackgroundText, true);
  });
}

Widget _getAppLogo({required double size, bool includeText = true}) {
  return MaterialApp(
    home: AppLogo(
      size: size,
      includeText: includeText,
    ),
  );
}
