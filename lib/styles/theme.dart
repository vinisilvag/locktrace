import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF1EADD),
    primaryColorLight: Color(0xFF574C3A),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF191816),
    primaryColorDark: Color(0xFFFFC632),
    textTheme: GoogleFonts.poppinsTextTheme(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFFFFC632),
      selectionHandleColor: Color(0xFFFFC632),
      selectionColor: Color(0xFFFFC632).withValues(alpha: 0.2),
    ),
  );
}
