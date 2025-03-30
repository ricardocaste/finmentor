import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 16),
              Text(text, style: textStyle),
            ],
          ),
        ),
      );
    }
}