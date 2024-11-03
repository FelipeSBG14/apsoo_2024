import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';

class GeneralInput extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final int? lines;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const GeneralInput({
    super.key,
    required this.label,
    this.lines,
    required this.hint,
    required this.controller,
    this.inputType,
    this.prefixIcon,
    this.validator,
    this.maxLines,
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
