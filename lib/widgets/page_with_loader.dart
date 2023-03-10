import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/loader.dart';

class PageWithLoader extends StatelessWidget {
  final Widget child;
  final bool showLoader;
  final String loaderText;

  const PageWithLoader({
    required this.child,
    required this.showLoader,
    required this.loaderText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Loader(
          show: showLoader,
          text: loaderText,
        ),
      ],
    );
  }
}
