import 'package:auth/auth.dart';
import 'package:core/core.dart' as core;
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 07 — Password Recovery (choose method: SMS or Email)
class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key, this.onNext, this.onCancel});

  final ValueChanged<String>? onNext; // 'sms' or 'email'
  final VoidCallback? onCancel;

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  String _selected = 'sms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // ── Blobs (top-right) ──────────────────────────────────────────────
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

          // ── Content ─────────────────────────────────────────────────────────
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
                    'Password Recovery',
                    style: ShoppeTypography.titleLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: ShoppeSpacing.sm),

                  Text(
                    'How you would like to restore\nyour password?',
                    textAlign: TextAlign.center,
                    style: ShoppeTypography.bodyLarge.copyWith(
                      color: ShoppeColors.grey700,
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xxl),

                  // SMS option
                  ShoppeRecoveryOption(
                    label: 'SMS',
                    isSelected: _selected == 'sms',
                    onTap: () => setState(() => _selected = 'sms'),
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  // Email option
                  ShoppeRecoveryOption(
                    label: 'Email',
                    isSelected: _selected == 'email',
                    onTap: () => setState(() => _selected = 'email'),
                  ),

                  const Spacer(),

                  ShoppeButton(
                    label: 'Next',
                    onPressed: () {
                      context.push(AuthRoutesPaths.passwordRecoveryCode);
                    },
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  GestureDetector(
                    onTap: widget.onCancel,
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: ShoppeTypography.linkSecondary,
                      ),
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
