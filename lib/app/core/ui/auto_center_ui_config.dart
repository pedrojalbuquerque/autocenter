import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoCenterUiConfig {
  AutoCenterUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color(0xff0093DD),
        primaryColorDark: const Color(0xff015EA1),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff015EA1),
            foregroundColor: Colors.white,
          ),
        ),        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xff015EA1),
          ),
        ),
      );
}
