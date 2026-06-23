import 'package:auth/src/composition/router/router.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 03 — Login
/// Matches the Shoppe UI Kit design exactly.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.onNext, this.onCancel});

  final ValueChanged<String>? onNext;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // ── Decorative blobs ──────────────────────────────────────────────

          // Light blue organic blob (behind the primary one)
          Positioned(
            top: 60,
            left: -20,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: ShoppeColors.primaryLight.withOpacity(0.55),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(999),
                  topRight: Radius.circular(999),
                  bottomRight: Radius.circular(999),
                  bottomLeft: Radius.circular(160),
                ),
              ),
            ),
          ),

          // Large primary blue circle — top-left, partially off-screen
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 340,
              height: 340,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Small primary blue blob — right edge, mid-screen
          Positioned(
            top: 340,
            right: -50,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(999),
                  bottomLeft: Radius.circular(999),
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(999),
                ),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Spacer that pushes content to the lower half
                const Spacer(),

                // Title + subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShoppeSpacing.pagePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login', style: ShoppeTypography.displayLarge),
                      const SizedBox(height: ShoppeSpacing.xs),
                      Row(
                        children: [
                          Text(
                            'Good to see you back!',
                            style: ShoppeTypography.bodyLarge.copyWith(
                              color: ShoppeColors.grey700,
                            ),
                          ),
                          const SizedBox(width: ShoppeSpacing.xs),
                          const Text('🖤', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: ShoppeSpacing.xl),

                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShoppeSpacing.pagePadding,
                  ),
                  child: ShoppeTextField(
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                ),

                const SizedBox(height: ShoppeSpacing.xl),

                // Next button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShoppeSpacing.pagePadding,
                  ),
                  child: ShoppeButton(
                    label: 'Next',
                    //onPressed: () => onNext?.call(emailController.text.trim()),
                    onPressed: () {
                      context.push(AuthRoutesPaths.password);
                    },
                  ),
                ),

                const SizedBox(height: ShoppeSpacing.base),

                // Cancel link
                GestureDetector(
                  onTap: onCancel,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: ShoppeTypography.linkSecondary,
                    ),
                  ),
                ),

                const SizedBox(height: ShoppeSpacing.xxxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
