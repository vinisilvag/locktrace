import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locktrace/services/auth_service.dart';

import 'package:locktrace/validators/form_validators.dart';
import 'package:locktrace/widgets/forms/snackbar.dart';

import 'package:locktrace/widgets/forms/text_field.dart';
import 'package:locktrace/widgets/forms/button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void navigateBack() {
    Navigator.pop(context);
  }

  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await authService.signUp(email: email, password: password);
    } on FirebaseAuthException catch (err) {
      showErrorSnackBar(context, err.message ?? "");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: navigateBack,
          icon: Icon(Icons.chevron_left),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
            padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 88),
                Text(
                  "Cadastrar",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC632),
                  ),
                ),

                SizedBox(height: 32),

                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                  child: Column(
                    spacing: 16,
                    children: [
                      // Email input
                      CustomTextField(
                        hintText: "Digite seu e-mail",
                        labelText: "E-mail",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        focus: _emailFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passwordFocus);
                        },
                        validator: emailValidator,
                        icon: LucideIcons.mail,
                      ),

                      // Password input
                      CustomTextField(
                        hintText: "Digite sua senha",
                        labelText: "Senha",
                        isPassword: true,
                        controller: _passwordController,
                        focus: _passwordFocus,
                        textInputAction: TextInputAction.done,
                        validator: passwordValidator,
                        icon: LucideIcons.lock,
                      ),

                      CustomButton(buttonText: "Cadastrar", onPressed: signUp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
