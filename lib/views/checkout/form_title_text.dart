import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';

class FormTitleText extends StatelessWidget {
  final String data;

  const FormTitleText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OnBackgroundText(
        data,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
