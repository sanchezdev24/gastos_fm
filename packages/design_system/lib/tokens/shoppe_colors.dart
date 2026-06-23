import 'package:flutter/material.dart';

/// Shoppe Color Tokens
/// Derived from the Shoppe eCommerce UI Kit screens.
abstract final class ShoppeColors {
  // ─── Primary ────────────────────────────────────────────────────────────────
  /// Main brand blue — buttons, active states, highlights.
  static const Color primary = Color(0xFF1A1AE6);

  /// Softer blue for blobs / decorative backgrounds.
  static const Color primaryLight = Color(0xFFB8C9FF);

  /// Very light blue — blob fill, input active bg, chip bg.
  static const Color primarySurface = Color(0xFFE8EEFF);

  // ─── Neutrals ───────────────────────────────────────────────────────────────
  static const Color black = Color(0xFF1A1A2E);
  static const Color grey900 = Color(0xFF212121);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);

  // ─── Semantic ───────────────────────────────────────────────────────────────
  /// Error / wrong-password red dots / validation.
  static const Color error = Color(0xFFE53935);

  /// Error surface — modal icon background.
  static const Color errorSurface = Color(0xFFFFEBEE);

  /// Success — Live badge, notification dot.
  static const Color success = Color(0xFF43A047);

  /// Flash sale / Send Again button pink.
  static const Color sale = Color(0xFFE91E63);

  /// Big Sale banner golden yellow.
  static const Color promo = Color(0xFFFFC107);

  // ─── Backgrounds ────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceVariant = Color(0xFFF0F2FF);

  // ─── Badge chips (discount labels) ──────────────────────────────────────────
  static const Color badgeDiscount = Color(0xFFE91E63);   // -20% red-pink
  static const Color badgeNew = Color(0xFF43A047);         // New green
  static const Color badgeHot = Color(0xFFFF5722);         // Hot orange
  static const Color badgeSale = sale;
}
