import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 09 — Setup New Password
class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({
    super.key,
    this.onSave,
    this.onCancel,
  });

  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final newPassCtrl    = TextEditingController();
    final repeatPassCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // ── Blobs ─────────────────────────────────────────────────────────
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
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
                color: ShoppeColors.primaryLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ShoppeSpacing.pagePadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: ShoppeSpacing.xxxl),

                  // Avatar
                  ShoppeAvatar(
                    size: 80,
                    showRing: true,
                    backgroundColor: const Color(0xFFF8BBD0),
                    child: const Text('😊', style: TextStyle(fontSize: 32)),
                  ),

                  const SizedBox(height: ShoppeSpacing.xl),

                  Text(
                    'Setup New Password',
                    style: ShoppeTypography.titleLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: ShoppeSpacing.sm),

                  Text(
                    'Please, setup a new password for\nyour account',
                    textAlign: TextAlign.center,
                    style: ShoppeTypography.bodyLarge.copyWith(
                      color: ShoppeColors.grey700,
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xxl),

                  // New password field
                  ShoppeTextField(
                    placeholder: 'New Password',
                    isPassword: true,
                    controller: newPassCtrl,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  // Repeat password field
                  ShoppeTextField(
                    placeholder: 'Repeat Password',
                    isPassword: true,
                    controller: repeatPassCtrl,
                  ),

                  const Spacer(),

                  ShoppeButton(
                    label: 'Save',
                    onPressed: onSave,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  GestureDetector(
                    onTap: onCancel,
                    child: Center(
                      child: Text('Cancel', style: ShoppeTypography.linkSecondary),
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}