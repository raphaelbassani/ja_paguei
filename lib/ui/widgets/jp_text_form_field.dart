import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../src/helpers/extensions.dart';

class JPTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final FormFieldValidator<String> validator;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onSaved;

  const JPTextFormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.inputAction,
    this.inputFormatters,
    this.keyboardType,
    this.autoFocus = false,
    this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: inputAction ?? TextInputAction.none,
      inputFormatters: inputFormatters,
      onChanged: validator,
      onTapOutside: (_) => context.unfocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        labelStyle: TextStyle(color: context.textColor),
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: context.textColor.withAlpha(150)),
      ),
      validator: validator,
    );
  }
}
