import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/space.dart';

class Loader extends StatelessWidget {
  final String text;
  final bool show;

  const Loader({
    super.key,
    required this.show,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (show) {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                const Space.vertical(20),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
