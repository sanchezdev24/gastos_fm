import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 02 — Create Account
/// Blobs top-right, avatar picker, email + password + phone fields,
/// Done + Cancel buttons.
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({
    super.key,
    this.onDone,
    this.onCancel,
    this.onPickAvatar,
  });

  final VoidCallback? onDone;
  final VoidCallback? onCancel;
  final VoidCallback? onPickAvatar;

  @override
  Widget build(BuildContext context) {
    final emailCtrl    = TextEditingController();
    final passwordCtrl = TextEditingController();
    final phoneCtrl    = TextEditingController();

    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // ── Decorative blobs (top-right) ─────────────────────────────────
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: -40,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: ShoppeSpacing.xl),

                  // Title
                  Text(
                    'Create\nAccount',
                    style: ShoppeTypography.displayLarge,
                  ),

                  const SizedBox(height: ShoppeSpacing.xxxl),

                  // Avatar picker
                  GestureDetector(
                    onTap: onPickAvatar,
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ShoppeColors.primary,
                          width: 2,
                          style: BorderStyle.none, // overridden by dashes below
                        ),
                      ),
                      child: CustomPaint(
                        painter: _DashedCirclePainter(color: ShoppeColors.primary),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: ShoppeColors.primary,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xxl),

                  // Email
                  ShoppeTextField(
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCtrl,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  // Password
                  ShoppeTextField(
                    placeholder: 'Password',
                    isPassword: true,
                    controller: passwordCtrl,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  // Phone with country flag prefix
                  ShoppeTextField(
                    placeholder: 'Your number',
                    keyboardType: TextInputType.phone,
                    controller: phoneCtrl,
                    prefixWidget: const _CountryPrefix(),
                  ),

                  const Spacer(),

                  // Done button
                  ShoppeButton(
                    label: 'Done',
                    onPressed: onDone,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),

                  // Cancel link
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

/// Flag + dial code prefix for phone field.
class _CountryPrefix extends StatelessWidget {
  const _CountryPrefix();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: ShoppeSpacing.base),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🇬🇧', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: ShoppeColors.grey700),
          const SizedBox(width: 8),
          Container(width: 1, height: 22, color: ShoppeColors.grey300),
        ],
      ),
    );
  }
}

/// Dashed circle border painter.
class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const dashCount = 20;
    const gapRatio  = 0.4;
    final radius    = size.width / 2 - 1;
    final center    = Offset(size.width / 2, size.height / 2);
    const step      = (2 * 3.14159265) / dashCount;
    final dashLen   = step * (1 - gapRatio);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * step;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashLen,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}