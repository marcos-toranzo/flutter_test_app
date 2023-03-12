import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/category/category_screen.dart';
import 'package:flutter_test_app/views/home/home_screen.dart';
import 'package:flutter_test_app/views/login_signup/login_signup_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/widgets/unknown_page.dart';

final routeBuilders = {
  LoginSignUpScreen.routeName: () => LoginSignUpScreen(),
  HomeScreen.routeName: () => HomeScreen(),
  CategoryScreen.routeName: () => CategoryScreen(),
};

class GetXRoutingService extends RoutingService {
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeBuilder = routeBuilders[settings.name];

    if (routeBuilder != null) {
      final arguments = settings.arguments;

      Transition? screenTransition;

      if (arguments is RouteArguments) {
        screenTransition =
            _screenTransitionsMap[arguments.screenTransitionType];
      }

      return GetPageRoute(
        page: routeBuilder,
        transition: screenTransition,
        settings: settings,
      );
    }

    // Unknown route
    logger.printExceptionError(
      description: 'PAGE UNKNOWN',
      message: 'Route "${settings.name}" does not exists',
    );

    return GetPageRoute(page: () => const UnknownPage());
  }

  @override
  Future<void> pushRoute<T>({
    required BuildContext context,
    required String routeName,
    RouteArguments? routeArguments,
  }) async {
    if (Get.currentRoute != routeName) {
      await Get.toNamed(routeName, arguments: routeArguments);
    }
  }

  @override
  Future<void> popAndPushRoute<T>({
    required BuildContext context,
    required String routeName,
    RouteArguments? routeArguments,
  }) async {
    if (Get.currentRoute != routeName) {
      await Get.offAndToNamed(routeName, arguments: routeArguments);
    }
  }

  @override
  Future<void> popAllAndPushRoute<T>({
    required BuildContext context,
    required String routeName,
    String? untilRouteName,
    RouteArguments? routeArguments,
  }) async {
    if (Get.currentRoute != routeName) {
      final predicate = untilRouteName != null
          ? (_) => Get.currentRoute == untilRouteName
          : (_) => false;

      await Get.offAllNamed(
        routeName,
        predicate: predicate,
        arguments: routeArguments,
      );
    }
  }

  @override
  void popRoute<T>(BuildContext context) {
    return Get.back();
  }
}

final _screenTransitionsMap = {
  ScreenTransitions.slide: Transition.rightToLeft,
};
