import 'package:flutter/material.dart';

enum ScreenTransitions {
  slide,
}

class RouteArguments {
  late final ScreenTransitions? transition;
  late final String? categoryName;
  late final String? bookId;

  RouteArguments({
    this.transition,
    this.categoryName,
    this.bookId,
  });

  RouteArguments.of(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null && args is RouteArguments) {
      transition = args.transition;
      categoryName = args.categoryName;
      bookId = args.bookId;
    } else {
      transition = null;
      categoryName = null;
      bookId = null;
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

  void popRoute<T>(BuildContext context);
}
