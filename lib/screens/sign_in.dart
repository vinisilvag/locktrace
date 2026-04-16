import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:locktrace/validators/form_validators.dart';
import 'package:locktrace/widgets/forms/forgot_password_dialog.dart';
import 'package:locktrace/widgets/forms/snackbar.dart';

import 'package:locktrace/widgets/forms/text_field.dart';
import 'package:locktrace/widgets/forms/button.dart';
import 'package:locktrace/widgets/forms/text_button.dart';

import 'package:locktrace/screens/sign_up.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void navigateToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const SignUpScreen()),
    );
  }

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (err) {
      showErrorSnackBar(context, err.message ?? "");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> openForgotPasswordDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const ForgotPasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
            padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  "Entrar",
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

                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          textButtonText: "Esqueci minha senha",
                          onTap: openForgotPasswordDialog,
                        ),
                      ),

                      CustomButton(
                        buttonText: "Entrar",
                        isLoading: isLoading,
                        onPressed: signIn,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: CustomTextButton(
                    textButtonText: "Registre-se",
                    onTap: navigateToSignUpScreen,
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
