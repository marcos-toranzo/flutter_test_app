import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/widgets/app_logo.dart';

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

  testWidgets('AppLogo should show correct structure', (tester) async {
    const size = 100.0;

    await tester.pumpWidget(_getAppLogo(size: size));

    final columnFinder = find.byType(Column);

    expect(columnFinder, findsOneWidget);

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
}

Widget _getAppLogo({required double size, bool includeText = true}) {
  return MaterialApp(
    home: AppLogo(
      size: size,
      includeText: includeText,
    ),
  );
}
