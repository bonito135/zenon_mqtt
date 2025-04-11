import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 2, 147, 144),
    primary: const Color.fromARGB(255, 0, 36, 51),
    secondary: const Color.fromARGB(255, 107, 165, 93),
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
);
