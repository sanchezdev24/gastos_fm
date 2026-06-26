import 'package:design_system/tokens/colors.dart';
import 'package:design_system/tokens/typography.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  AppTheme._();

  static const _radius = BorderRadius.all(Radius.circular(8));

  static ShadColorScheme get _lightColorScheme => ShadColorScheme(
    background: AppColors.surface,
    foreground: AppColors.onSurface,
    card: AppColors.surfaceContainerLowest,
    cardForeground: AppColors.onSurface,
    popover: AppColors.surfaceContainerLow,
    popoverForeground: AppColors.onSurface,
    primary: AppColors.primary,
    primaryForeground: AppColors.onPrimary,
    secondary: AppColors.secondaryContainer,
    secondaryForeground: AppColors.onSecondaryContainer,
    muted: AppColors.surfaceContainer,
    mutedForeground: AppColors.onSurfaceVariant,
    accent: AppColors.surfaceContainerHigh,
    accentForeground: AppColors.onSurface,
    destructive: AppColors.error,
    destructiveForeground: AppColors.onError,
    border: AppColors.outlineVariant,
    input: AppColors.outlineVariant,
    ring: AppColors.primary,
    selection: AppColors.primaryContainer,
  );

  static ShadThemeData get light => ShadThemeData(
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    radius: _radius,
    textTheme: ShadTextTheme(
      family: 'Inter',
      h1Large: AppTypography.displayLg,
      h1: AppTypography.displayLgMobile,
      h4: AppTypography.headlineMd,
      p: AppTypography.bodyLg,
      small: AppTypography.bodySm,
      muted: AppTypography.labelCaps,
    ),
  );

  // dark: mismo approach con inverseSurface / inverseOnSurface,
  // fondo navy-charcoal en vez de negro puro (ver DESIGN.md > Colors)
}
