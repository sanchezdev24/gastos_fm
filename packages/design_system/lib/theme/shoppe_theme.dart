import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../tokens/shoppe_colors.dart';
import '../tokens/shoppe_typography.dart';
import '../tokens/shoppe_tokens.dart';

/// ShadCN-based theme for the Shoppe eCommerce app.
///
/// Usage:
/// ```dart
/// ShadApp.router(
///   theme: ShoppeTheme.light,
///   darkTheme: ShoppeTheme.dark,
///   ...
/// )
/// ```
abstract final class ShoppeTheme {
  // ─── Light Theme ─────────────────────────────────────────────────────────────
  static ShadThemeData get light => ShadThemeData(
        brightness: Brightness.light,
        colorScheme: ShadColorScheme.fromName(
          'blue',
          brightness: Brightness.light,
        ),
        primaryButtonTheme: ShadButtonTheme(
          height: 56,
          backgroundColor: ShoppeColors.primary,
          foregroundColor: ShoppeColors.white,
          hoverBackgroundColor: const Color(0xFF1414C8),
          textStyle: ShoppeTypography.buttonLabel,
          shadows: ShoppeShadows.cardShadow,
        ),
        secondaryButtonTheme: ShadButtonTheme(
          height: 56,
          backgroundColor: Colors.transparent,
          foregroundColor: ShoppeColors.primary,
          textStyle: ShoppeTypography.buttonLabel.copyWith(
            color: ShoppeColors.primary,
          ),
        ),
        inputTheme: ShadInputTheme(
          style: ShoppeTypography.bodyLarge,
          placeholderStyle: ShoppeTypography.inputHint,
          padding: const EdgeInsets.symmetric(
            horizontal: ShoppeSpacing.base,
            vertical: ShoppeSpacing.base,
          ),
        ),
      );

  // ─── Dark Theme (stub) ───────────────────────────────────────────────────────
  static ShadThemeData get dark => ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadColorScheme.fromName(
          'blue',
          brightness: Brightness.dark,
        ),
      );
}

/// MaterialTheme wrapper for non-shadcn widgets.
ThemeData shoppeFlutterTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: ShoppeColors.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ShoppeColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: ShoppeColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: ShoppeTypography.headlineMedium,
      iconTheme: IconThemeData(color: ShoppeColors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ShoppeColors.background,
      selectedItemColor: ShoppeColors.primary,
      unselectedItemColor: ShoppeColors.grey500,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ShoppeColors.surface,
      hintStyle: ShoppeTypography.inputHint,
      border: OutlineInputBorder(
        borderRadius: ShoppeRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ShoppeRadius.inputRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ShoppeRadius.inputRadius,
        borderSide: const BorderSide(color: ShoppeColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ShoppeSpacing.base,
        vertical: ShoppeSpacing.base,
      ),
    ),
  );
}