import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
/// Screen 10 — Maximum Attempts
/// Same layout as screen 08 but with a dark overlay + error dialog on top.
/// Typically shown by calling [ShoppeMaxAttemptsDialog.show] from the
/// [PasswordRecoveryCodeScreen]. This file provides a full standalone version.
class MaximumAttemptsScreen extends StatelessWidget {
  const MaximumAttemptsScreen({
    super.key,
    this.onOkay,
    this.onSendAgain,
    this.onCancel,
  });

  final VoidCallback? onOkay;
  final VoidCallback? onSendAgain;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // ── Background (same as screen 08, dimmed) ─────────────────────────
          Stack(
            children: [
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1414A0), // dimmed primary
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: -30,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: ShoppeColors.primaryLight.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShoppeSpacing.pagePadding,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: ShoppeSpacing.xxxl),
                      ShoppeAvatar(
                        size: 80,
                        showRing: true,
                        backgroundColor: const Color(0xFFB08090),
                        child: const Text('😊', style: TextStyle(fontSize: 32, color: Colors.white54)),
                      ),
                      const SizedBox(height: ShoppeSpacing.xl),
                      Text('Password Recovery',
                          style: ShoppeTypography.titleLarge
                              .copyWith(color: ShoppeColors.grey700)),
                      const SizedBox(height: ShoppeSpacing.sm),
                      Text(
                        'Enter 4-digits code we sent you\non your phone number',
                        textAlign: TextAlign.center,
                        style: ShoppeTypography.bodyLarge
                            .copyWith(color: ShoppeColors.grey500),
                      ),
                      const Spacer(),
                      // Dimmed send again
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: ShoppeColors.grey700,
                          borderRadius: ShoppeRadius.buttonRadius,
                        ),
                        alignment: Alignment.center,
                        child: Text('Send Again',
                            style: ShoppeTypography.buttonLabel
                                .copyWith(color: ShoppeColors.grey500)),
                      ),
                      const SizedBox(height: ShoppeSpacing.base),
                      Text('Cancel', style: ShoppeTypography.linkSecondary
                          .copyWith(color: ShoppeColors.grey500)),
                      const SizedBox(height: ShoppeSpacing.xl),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Dark scrim ────────────────────────────────────────────────────
          Container(color: Colors.black54),

          // ── Error dialog ──────────────────────────────────────────────────
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Dialog card
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: ShoppeSpacing.xxl,
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                  decoration: BoxDecoration(
                    color: ShoppeColors.white,
                    borderRadius: ShoppeRadius.dialogRadius,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You reached out maximum\namount of attempts.\nPlease, try later.',
                        textAlign: TextAlign.center,
                        style: ShoppeTypography.bodyLarge,
                      ),
                      const SizedBox(height: ShoppeSpacing.xl),
                      ShoppeButton(
                        label: 'Okay',
                        onPressed: onOkay,
                        height: 52,
                      ),
                    ],
                  ),
                ),

                // Error icon floating above card
                Positioned(
                  top: -28,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: ShoppeColors.errorSurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: ShoppeColors.error,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}