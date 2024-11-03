import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;
  const MenuButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.isSelected,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? const Color.fromARGB(255, 134, 133, 133)
                : Colors.grey[300],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
