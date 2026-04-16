import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String textButtonText;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.textButtonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        textButtonText,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFC632),
        ),
      ),
    );
  }
}
