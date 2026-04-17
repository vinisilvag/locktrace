import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locktrace/services/auth_service.dart';
import 'package:locktrace/utils/firebase_errors.dart';

import 'package:locktrace/widgets/forms/text_field.dart';
import 'package:locktrace/widgets/forms/button.dart';
import 'package:locktrace/widgets/forms/snackbar.dart';

import 'package:locktrace/validators/form_validators.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isLoading = false;

  final authService = AuthService();

  Future<void> forgotPassword() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    final email = _emailController.text.trim();

    try {
      await authService.sendPasswordReset(email);
      showSuccessSnackBar(context, "E-mail de recuperação enviado.");
      Navigator.pop(context);
    } on FirebaseAuthException catch (err) {
      showErrorSnackBar(context, handleFirebaseError(err));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF191816),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      content: SizedBox(
        width: 340,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: "Digite seu e-mail",
                labelText: "E-mail",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                textInputAction: TextInputAction.done,
                validator: emailValidator,
                icon: LucideIcons.mail,
              ),

              const SizedBox(height: 16),

              CustomButton(
                buttonText: "Enviar e-mail",
                isLoading: isLoading,
                onPressed: forgotPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
