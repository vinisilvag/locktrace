import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xffcf6679),
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 148, 207, 102),
    ),
  );
}
