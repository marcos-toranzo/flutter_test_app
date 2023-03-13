import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/currency.dart';

enum ScreenTransitions {
  slide,
}

class RouteArguments {
  late final ScreenTransitions? transition;
  late final String? categoryName;
  late final String? bookId;
  late final Currency? toPay;

  RouteArguments({
    this.transition,
    this.categoryName,
    this.bookId,
    this.toPay,
  });

  RouteArguments.of(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null && args is RouteArguments) {
      transition = args.transition;
      categoryName = args.categoryName;
      bookId = args.bookId;
      toPay = args.toPay;
    } else {
      transition = null;
      categoryName = null;
      bookId = null;
      toPay = null;
    }
  }
}

abstract class RoutingService {
  Route<dynamic>? onGenerateRoute(RouteSettings settings);

  Future<void> pushRoute<T>({
    required BuildContext context,
    required String routeName,
    RouteArguments? routeArguments,
  });

  Future<void> popAndPushRoute<T>({
    required BuildContext context,
    required String routeName,
    RouteArguments? routeArguments,
  });

  Future<void> popAllAndPushRoute<T>({
    required BuildContext context,
    required String routeName,
    String? untilRouteName,
    RouteArguments? routeArguments,
  });

  Future<void> popUntil<T>({
    required BuildContext context,
    required String untilRouteName,
  });

  void popRoute<T>(BuildContext context);
}
