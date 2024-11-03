// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ModalExclusao extends StatelessWidget {
  final VoidCallback? onPressed;
  final String message;
  const ModalExclusao({
    super.key,
    this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar Exclusão'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o modal sem excluir
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Excluir',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
