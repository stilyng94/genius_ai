import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Themes {
  static ThemeData lightTheme = FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.blueM3,
    useMaterial3ErrorColors: true,
    textTheme: GoogleFonts.robotoTextTheme(),
    fontFamily: GoogleFonts.roboto().fontFamily,
    primaryTextTheme: GoogleFonts.robotoTextTheme(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  static ThemeData darkTheme = FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.deepOrangeM3,
    useMaterial3ErrorColors: true,
    textTheme: GoogleFonts.robotoTextTheme(),
    fontFamily: GoogleFonts.roboto().fontFamily,
    primaryTextTheme: GoogleFonts.robotoTextTheme(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
}
