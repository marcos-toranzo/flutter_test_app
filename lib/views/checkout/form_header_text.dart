import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';

class FormHeaderText extends StatelessWidget {
  final String data;

  const FormHeaderText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OnBackgroundText(
        data,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
