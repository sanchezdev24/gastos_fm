import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 08 — Password Recovery + Code
/// 4-dot OTP input, masked phone number, "Send Again" pink button.
class PasswordRecoveryCodeScreen extends StatefulWidget {
  const PasswordRecoveryCodeScreen({
    super.key,
    this.maskedPhone = '+98********00',
    this.onSendAgain,
    this.onCancel,
    this.onComplete,
  });

  final String maskedPhone;
  final VoidCallback? onSendAgain;
  final VoidCallback? onCancel;
  final ValueChanged<String>? onComplete;

  @override
  State<PasswordRecoveryCodeScreen> createState() =>
      _PasswordRecoveryCodeScreenState();
}

class _PasswordRecoveryCodeScreenState
    extends State<PasswordRecoveryCodeScreen> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
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
                    'Password Recovery',
                    style: ShoppeTypography.titleLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: ShoppeSpacing.sm),

                  Text(
                    'Enter 4-digits code we sent you\non your phone number',
                    textAlign: TextAlign.center,
                    style: ShoppeTypography.bodyLarge.copyWith(
                      color: ShoppeColors.grey700,
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.sm),

                  // Masked phone number
                  Text(
                    widget.maskedPhone,
                    style: ShoppeTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ShoppeColors.black,
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xl),

                  // 4-dot OTP row
                  ShoppePinRow(
                    length: 4,
                    filled: _code.length.clamp(0, 4),
                    dotSize: 22,
                    gap: 16,
                  ),

                  const Spacer(),

                  // Hidden text field captures keyboard input
                  SizedBox(
                    width: 0,
                    height: 0,
                    child: TextField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: const InputDecoration(counterText: ''),
                      onChanged: (v) {
                        setState(() => _code = v);
                        if (v.length == 4) widget.onComplete?.call(v);
                      },
                    ),
                  ),

                  // Send Again button (pink/sale color)
                  ShoppeButton(
                    label: 'Send Again',
                    variant: ShoppeButtonVariant.secondary,
                    onPressed: widget.onSendAgain,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  GestureDetector(
                    onTap: widget.onCancel,
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