import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JPTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final FormFieldValidator<String> validator;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const JPTextFormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.inputAction,
    this.inputFormatters,
    this.keyboardType,
    this.autoFocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyMedium =
        Theme.of(context).textTheme.bodyMedium ?? TextStyle();

    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: inputAction ?? TextInputAction.none,
      inputFormatters: inputFormatters,
      onChanged: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: bodyMedium.color?.withAlpha(150)),
      ),
      validator: validator,
    );
  }
}
