import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final List<Widget> fields;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormState>? formKey;

  const CustomForm({
    required this.fields,
    this.autovalidateMode,
    this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(
        children: fields,
      ),
    );
  }
}
