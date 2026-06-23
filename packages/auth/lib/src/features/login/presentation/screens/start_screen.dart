import 'package:auth/src/composition/router/auth_routes_paths.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 01 — Start
/// Logo centrado, nombre de la app, subtítulo, CTA principal y link de login.
class StartScreen extends StatelessWidget {
  const StartScreen({super.key, this.onGetStarted, this.onAlreadyHaveAccount});

  final VoidCallback? onGetStarted;
  final VoidCallback? onAlreadyHaveAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ShoppeSpacing.pagePadding,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // ── App logo ──────────────────────────────────────────────────
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: ShoppeColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: ShoppeShadows.elevatedShadow,
                ),
                child: const Center(child: _ShoppingBagIcon()),
              ),

              const SizedBox(height: ShoppeSpacing.xl),

              // ── App name ─────────────────────────────────────────────────
              Text(
                'Shoppe',
                style: ShoppeTypography.displayLarge.copyWith(fontSize: 48),
              ),

              const SizedBox(height: ShoppeSpacing.sm),

              // ── Subtitle ──────────────────────────────────────────────────
              Text(
                'Beautiful eCommerce UI Kit\nfor your online store',
                textAlign: TextAlign.center,
                style: ShoppeTypography.bodyLarge.copyWith(
                  color: ShoppeColors.grey700,
                  height: 1.6,
                ),
              ),

              const Spacer(flex: 2),

              // ── CTA ───────────────────────────────────────────────────────
              ShoppeButton(
                label: "Let's get started",
                onPressed: () {
                  context.push(AuthRoutesPaths.login);
                },
              ),

              const SizedBox(height: ShoppeSpacing.base),

              // ── Already have account ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I already have an account',
                    style: ShoppeTypography.linkSecondary,
                  ),
                  const SizedBox(width: ShoppeSpacing.sm),
                  ShoppeCircleIconButton(
                    onPressed: () {
                      context.push(AuthRoutesPaths.createAccount);
                    },
                    size: 40,
                  ),
                ],
              ),

              const SizedBox(height: ShoppeSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

/// SVG-style shopping bag drawn with Flutter Canvas.
class _ShoppingBagIcon extends StatelessWidget {
  const _ShoppingBagIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: CustomPaint(painter: _BagPainter()),
    );
  }
}

class _BagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Back bag (light blue)
    final back = Paint()..color = ShoppeColors.primaryLight;
    final backRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.3, h * 0.28, w * 0.62, h * 0.65),
      const Radius.circular(6),
    );
    canvas.drawRRect(backRect, back);

    // Front bag (primary blue)
    final front = Paint()..color = ShoppeColors.primary;
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.08, h * 0.34, w * 0.62, h * 0.60),
      const Radius.circular(6),
    );
    canvas.drawRRect(frontRect, front);

    // Handle
    final handle = Paint()
      ..color = ShoppeColors.primary.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.08
      ..strokeCap = StrokeCap.round;
    final handlePath = Path()
      ..moveTo(w * 0.22, h * 0.34)
      ..cubicTo(w * 0.22, h * 0.10, w * 0.55, h * 0.10, w * 0.55, h * 0.34);
    canvas.drawPath(handlePath, handle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
