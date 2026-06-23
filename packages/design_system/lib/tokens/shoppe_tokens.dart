import 'package:flutter/material.dart';
import 'shoppe_colors.dart';

// ─── Spacing ──────────────────────────────────────────────────────────────────
/// 4px-based scale.
abstract final class ShoppeSpacing {
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double base = 16;
  static const double lg  = 20;
  static const double xl  = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Standard horizontal page padding.
  static const double pagePadding = 16;

  /// Vertical gap between sections.
  static const double sectionGap = 24;

  /// Gap between cards in a grid/row.
  static const double cardGap = 12;
}

// ─── Border Radius ────────────────────────────────────────────────────────────
abstract final class ShoppeRadius {
  static const double xs   = 4;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 20;
  static const double xxl  = 24;
  static const double full = 999;

  // Convenience BorderRadius constructors
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(full));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(full));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius badgeRadius = BorderRadius.only(
    topRight: Radius.circular(md),
    bottomLeft: Radius.circular(md),
  );
  static const BorderRadius dialogRadius = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius storyCardRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius heroBannerRadius = BorderRadius.all(Radius.circular(lg));
}

// ─── Shadows ──────────────────────────────────────────────────────────────────
abstract final class ShoppeShadows {
  /// Light card shadow — product cards, input fields.
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Elevated shadow — profile avatar, dialog.
  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  /// Bottom nav bar shadow.
  static const List<BoxShadow> navBarShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 16,
      offset: Offset(0, -4),
    ),
  ];

  /// Avatar ring — white border on profile pic.
  static List<BoxShadow> avatarRing = [
    BoxShadow(
      color: ShoppeColors.white,
      spreadRadius: 3,
      blurRadius: 0,
    ),
  ];
}

// ─── Animation Durations ─────────────────────────────────────────────────────
abstract final class ShoppeDurations {
  static const Duration fast   = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow   = Duration(milliseconds: 400);
  static const Duration pageTransition = Duration(milliseconds: 300);
}

// ─── Curves ───────────────────────────────────────────────────────────────────
abstract final class ShoppeCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve enter    = Curves.easeOut;
  static const Curve exit     = Curves.easeIn;
  static const Curve spring   = Curves.elasticOut;
}

// ─── Icon Sizes ───────────────────────────────────────────────────────────────
abstract final class ShoppeIconSizes {
  static const double sm   = 16;
  static const double base = 20;
  static const double lg   = 24;
  static const double xl   = 28;
}
