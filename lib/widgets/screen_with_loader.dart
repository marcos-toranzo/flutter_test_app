import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/row_with_padding.dart';

class ScreenWithLoader extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool isLoading;

  const ScreenWithLoader({
    super.key,
    this.body,
    this.drawer,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (body != null) body!,
          if (isLoading)
            RowWithPadding(
              padding: const EdgeInsets.only(top: 10),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
                  borderRadius: BorderRadius.circular(100),
                  elevation: 10,
                  child: ColumnWithPadding(
                    padding: const EdgeInsets.all(10),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
