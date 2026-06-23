import 'package:auth/auth.dart';
import 'package:core/core.dart' as core;
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
// Screens 04, 05, 06 — Password entry states
// Shared base + three public exports.
// ════════════════════════════════════════════════════════════════════════════

/// Screen 04 — Password (empty PIN, no keyboard)
class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key, this.onNotYou});
  final VoidCallback? onNotYou;

  @override
  Widget build(BuildContext context) => _PasswordBaseScreen(
    filled: 0,
    hasError: false,
    showForgot: false,
    showKeyboard: false,
    onNotYou: onNotYou,
  );
}

/// Screen 05 — Password Typing (5 of 8 dots filled, keyboard visible)
class PasswordTypingScreen extends StatefulWidget {
  const PasswordTypingScreen({super.key, this.onNotYou, this.onSubmit});
  final VoidCallback? onNotYou;
  final ValueChanged<String>? onSubmit;

  @override
  State<PasswordTypingScreen> createState() => _PasswordTypingScreenState();
}

class _PasswordTypingScreenState extends State<PasswordTypingScreen> {
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return _PasswordBaseScreen(
      filled: _input.length.clamp(0, 8),
      hasError: false,
      showForgot: false,
      showKeyboard: true,
      onNotYou: widget.onNotYou,
      onKeyTap: (key) => setState(() {
        if (key == '⌫') {
          if (_input.isNotEmpty)
            _input = _input.substring(0, _input.length - 1);
        } else if (_input.length < 8) {
          _input += key;
          if (_input.length == 8) widget.onSubmit?.call(_input);
        }
      }),
    );
  }
}

/// Screen 06 — Wrong Password (8 red dots + "Forgot your password?")
class WrongPasswordScreen extends StatelessWidget {
  const WrongPasswordScreen({super.key, this.onNotYou, this.onForgotPassword});
  final VoidCallback? onNotYou;
  final VoidCallback? onForgotPassword;

  @override
  Widget build(BuildContext context) => _PasswordBaseScreen(
    filled: 8,
    hasError: true,
    showForgot: true,
    showKeyboard: true,
    onNotYou: onNotYou,
    onForgotPassword: onForgotPassword,
  );
}

// ── Shared base widget ───────────────────────────────────────────────────────

class _PasswordBaseScreen extends StatelessWidget {
  const _PasswordBaseScreen({
    required this.filled,
    required this.hasError,
    required this.showForgot,
    required this.showKeyboard,
    this.onNotYou,
    this.onForgotPassword,
    this.onKeyTap,
  });

  final int filled;
  final bool hasError;
  final bool showForgot;
  final bool showKeyboard;
  final VoidCallback? onNotYou;
  final VoidCallback? onForgotPassword;
  final ValueChanged<String>? onKeyTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Blobs ─────────────────────────────────────────────────────────
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: ShoppeColors.primaryLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: ShoppeSpacing.xxxl),

                // Avatar
                ShoppeAvatar(
                  size: 88,
                  showRing: true,
                  backgroundColor: const Color(0xFFF8BBD0),
                  child: const Text('😊', style: TextStyle(fontSize: 36)),
                ),

                const SizedBox(height: ShoppeSpacing.xl),

                // Greeting
                Text(
                  'Hello, Romina!!',
                  style: ShoppeTypography.headlineLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ShoppeSpacing.sm),

                Text(
                  'Type your password',
                  style: ShoppeTypography.bodyLarge.copyWith(
                    color: ShoppeColors.grey700,
                  ),
                ),

                const SizedBox(height: ShoppeSpacing.xl),

                // PIN dots
                ShoppePinRow(
                  length: 8,
                  filled: filled,
                  hasError: hasError,
                  dotSize: 18,
                  gap: 12,
                ),

                if (showForgot) ...[
                  const SizedBox(height: ShoppeSpacing.base),
                  GestureDetector(
                    onTap: onForgotPassword,
                    child: Text(
                      'Forgot your password?',
                      style: ShoppeTypography.bodyMedium.copyWith(
                        color: ShoppeColors.grey700,
                      ),
                    ),
                  ),
                ],

                const Spacer(),

                // "Not you?" link + arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not you?', style: ShoppeTypography.linkSecondary),
                    const SizedBox(width: ShoppeSpacing.sm),
                    ShoppeCircleIconButton(
                      onPressed: () {
                        context.push(AuthRoutesPaths.createAccount);
                      },
                      size: 40,
                    ),
                  ],
                ),

                // Keyboard hint (screens 05 & 06 show system keyboard)
                if (showKeyboard) ...[
                  const SizedBox(height: ShoppeSpacing.base),
                  _FakeKeyboard(onKeyTap: onKeyTap),
                ] else
                  const SizedBox(height: ShoppeSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Simplified visual keyboard — mirrors system keyboard look.
class _FakeKeyboard extends StatelessWidget {
  const _FakeKeyboard({this.onKeyTap});
  final ValueChanged<String>? onKeyTap;

  static const _rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['⇧', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '⌫'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD1D5DB),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          for (final row in _rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row
                    .map((k) => _Key(label: k, onTap: onKeyTap))
                    .toList(),
              ),
            ),
          // Space row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Key(label: '123', width: 44, onTap: (_) {}),
                const SizedBox(width: 6),
                _Key(
                  label: 'space',
                  width: 180,
                  onTap: (_) => onKeyTap?.call(' '),
                ),
                const SizedBox(width: 6),
                _Key(label: 'Go', width: 44, onTap: (_) {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.label, required this.onTap, this.width = 32});
  final String label;
  final ValueChanged<String>? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(label),
      child: Container(
        width: width,
        height: 42,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: ShoppeColors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, color: ShoppeColors.black),
        ),
      ),
    );
  }
}
