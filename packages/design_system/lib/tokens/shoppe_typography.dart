import 'package:flutter/material.dart';
import 'shoppe_colors.dart';

/// Shoppe Typography Tokens
/// Scale derived from the UI kit screens.
/// Font family: system default (SF Pro / Roboto). Swap to a custom font
/// (e.g., "Nunito") by providing fontFamily to each style.
abstract final class ShoppeTypography {
  // ─── Display ─────────────────────────────────────────────────────────────────
  /// Login / Create Account / Flash Sale — large hero titles.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
    color: ShoppeColors.black,
  );

  /// Section card titles like "Hello" / "Ready?".
  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: ShoppeColors.black,
  );

  // ─── Headline ────────────────────────────────────────────────────────────────
  /// "Hello, Romina!!" / profile greeting.
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: ShoppeColors.black,
  );

  /// Section headers: "Top Products", "Flash Sale", "Categories".
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: ShoppeColors.black,
  );

  /// Sub-section headers / card section title.
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: ShoppeColors.black,
  );

  // ─── Title ───────────────────────────────────────────────────────────────────
  /// Password Recovery title, Setup New Password.
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: ShoppeColors.black,
  );

  /// Navbar labels, chip labels, filter labels.
  static const TextStyle titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: ShoppeColors.black,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: ShoppeColors.black,
  );

  // ─── Body ────────────────────────────────────────────────────────────────────
  /// Product name, announcement body, card body text.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: ShoppeColors.black,
  );

  /// Product description / lorem placeholder text.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: ShoppeColors.grey700,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: ShoppeColors.grey500,
  );

  // ─── Price ───────────────────────────────────────────────────────────────────
  /// Current price — "$16,00".
  static const TextStyle priceCurrent = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ShoppeColors.black,
  );

  /// Original price struck-through — "$20,00".
  static const TextStyle priceOriginal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ShoppeColors.grey500,
    decoration: TextDecoration.lineThrough,
    decorationColor: ShoppeColors.grey500,
  );

  // ─── Label / Utility ─────────────────────────────────────────────────────────
  /// Button labels.
  static const TextStyle buttonLabel = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: ShoppeColors.white,
  );

  /// Timer digits (00 36 58).
  static const TextStyle timerDigit = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ShoppeColors.white,
    letterSpacing: 1,
  );

  /// Badge / chip small label ("-20%").
  static const TextStyle badgeLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: ShoppeColors.white,
    letterSpacing: 0.2,
  );

  /// Category item count ("109").
  static const TextStyle categoryCount = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: ShoppeColors.grey500,
  );

  /// "See All" link label.
  static const TextStyle seeAll = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ShoppeColors.grey700,
  );

  /// Announcement bold key.
  static const TextStyle announcementTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ShoppeColors.black,
  );

  /// Input placeholder / hint.
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ShoppeColors.grey500,
  );

  /// Cancel / secondary link text.
  static const TextStyle linkSecondary = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: ShoppeColors.grey700,
  );
}
