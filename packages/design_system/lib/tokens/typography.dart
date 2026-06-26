import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displayLg => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.02 * 32,
  );

  static TextStyle get displayLgMobile => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    letterSpacing: -0.02 * 28,
  );

  static TextStyle get headlineMd => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    letterSpacing: -0.01 * 20,
  );

  static TextStyle get bodyLg => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static TextStyle get bodySm => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  static TextStyle get labelCaps => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.05 * 12,
  );

  /// Para cifras financieras: agrega `fontFeatures: [FontFeature.tabularFigures()]`
  static TextStyle get numericData => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
