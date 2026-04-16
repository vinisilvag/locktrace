String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite um email';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Digite um e-mail válido';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite uma senha';
  }
  if (value.length < 6) {
    return 'Mínimo de 6 caracteres';
  }
  return null;
}
