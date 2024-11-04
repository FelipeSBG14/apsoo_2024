// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';

class GeneralInput extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final int? lines;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const GeneralInput({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines,
    this.lines,
    this.inputType,
    this.prefixIcon,
    required this.controller,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: context.textStyles.textRegular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          maxLines: lines,
          maxLength: maxLines,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: context.textStyles.textRegular.copyWith(
              color: Colors.grey,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
