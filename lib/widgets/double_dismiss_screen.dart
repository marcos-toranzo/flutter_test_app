import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';

/// Widget that only dismisses the route if user presses
/// Back twice within the specified time.
class DoubleDismissScreen extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const DoubleDismissScreen({
    required this.child,
    this.duration = const Duration(seconds: 2),
    Key? key,
  }) : super(key: key);

  @override
  State<DoubleDismissScreen> createState() => _DoubleDismissScreenState();
}

class _DoubleDismissScreenState extends State<DoubleDismissScreen> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (_timer?.isActive == true) {
          _timer!.cancel();
          return true;
        }

        _timer = Timer(widget.duration, () {});

        showSnackBar(
          context: context,
          text: translations.pressBackAgainToExitApp,
        );

        return false;
      },
      child: widget.child,
    );
  }
}
