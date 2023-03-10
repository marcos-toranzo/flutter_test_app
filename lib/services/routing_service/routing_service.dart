import 'package:flutter/material.dart';

enum ScreenTransitions {
  slide,
}

class RouteArguments {
  final ScreenTransitions? screenTransitionType;

  const RouteArguments({
    this.screenTransitionType,
  });
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
