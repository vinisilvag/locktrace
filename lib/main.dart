import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locktrace/screens/home.dart';
import 'package:locktrace/styles/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:locktrace/firebase_options.dart';

import 'package:locktrace/screens/sign_in.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LockTraceApp());
}

class LockTraceApp extends StatefulWidget {
  const LockTraceApp({super.key});

  @override
  State<LockTraceApp> createState() => _LockTraceAppState();
}

class _LockTraceAppState extends State<LockTraceApp> {
  void initialization() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LockTrace',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            initialization();
          }

          if (snapshot.data != null) {
            return const HomeScreen();
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
