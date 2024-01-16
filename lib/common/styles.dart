import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color lightGrey = const Color(0xFFEEEEEE);
Color amberYellow = const Color(0xFFFFD369);
Color thirdGrey = const Color(0xFF464A52);
Color secondGrey = const Color(0xFF353A42);
Color charcoalGrey = const Color(0xFF393E46);
Color midnightBlue = const Color(0xFF222831);
Color labelColor = const Color(0xFFA5A5A5);

final TextTheme myTextTheme = TextTheme(
  titleLarge: GoogleFonts.biryani(fontSize: 28, fontWeight: FontWeight.w700),
  titleMedium: GoogleFonts.biryani(fontSize: 21, fontWeight: FontWeight.w500),
  bodySmall: GoogleFonts.biryani(fontSize: 10, fontWeight: FontWeight.w300),
  bodyMedium: GoogleFonts.biryani(fontSize: 14, fontWeight: FontWeight.w300),
  bodyLarge: GoogleFonts.biryani(fontSize: 24, fontWeight: FontWeight.w700),
  labelMedium: GoogleFonts.biryani(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: labelColor.withOpacity(0.3),
  ),
  labelLarge: GoogleFonts.biryani(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: charcoalGrey,
  ),
  labelSmall: GoogleFonts.biryani(
    fontSize: 12,
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
);

TextStyle charcoalTextStyle = GoogleFonts.biryani(
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: const Color(0xFFA5A5A5),
);

TextStyle midnightBlueTextStyle = GoogleFonts.biryani(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: midnightBlue,
);
