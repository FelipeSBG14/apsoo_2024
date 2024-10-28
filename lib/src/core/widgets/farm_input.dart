import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';

class FarmInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const FarmInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.inputType,
    this.prefixIcon,
    this.validator,
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
