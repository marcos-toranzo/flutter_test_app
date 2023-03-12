import 'package:flutter/material.dart';

enum ScreenTransitions {
  slide,
}

class RouteArguments {
  late final ScreenTransitions? screenTransitionType;
  late final String? categoryName;

  RouteArguments({
    this.screenTransitionType,
    this.categoryName,
  });

  RouteArguments.of(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null && args is RouteArguments) {
      screenTransitionType = args.screenTransitionType;
      categoryName = args.categoryName;
    } else {
      screenTransitionType = null;
      categoryName = null;
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
