import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
// Screens 11 & 12 — Onboarding cards (Hello / Ready?)
// Shared base + two public widgets.
// ════════════════════════════════════════════════════════════════════════════

/// Screen 11 — Hello Card (onboarding step 2 of 4)
class HelloCardScreen extends StatelessWidget {
  const HelloCardScreen({super.key, this.onNext});
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) => _OnboardingCardScreen(
        currentPage: 1,
        totalPages: 4,
        title: 'Hello',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed non consectetur turpis. Morbi eu eleifend lacus.',
        onNext: onNext,
        imageBuilder: _helloImage,
      );
}

/// Screen 12 — Ready Card (onboarding step 4 of 4)
class ReadyCardScreen extends StatelessWidget {
  const ReadyCardScreen({super.key, this.onStart});
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) => _OnboardingCardScreen(
        currentPage: 3,
        totalPages: 4,
        title: 'Ready?',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        showStartButton: true,
        onNext: onStart,
        imageBuilder: _readyImage,
      );
}

// ── Image placeholders ───────────────────────────────────────────────────────

Widget _helloImage() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ShoppeRadius.xxl),
          topRight: Radius.circular(ShoppeRadius.xxl),
        ),
      ),
      child: const Center(
        child: Text('🛍️', style: TextStyle(fontSize: 72)),
      ),
    );

Widget _readyImage() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFBBDEFB), Color(0xFFFCE4EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ShoppeRadius.xxl),
          topRight: Radius.circular(ShoppeRadius.xxl),
        ),
      ),
      child: const Center(
        child: Text('🛒', style: TextStyle(fontSize: 72)),
      ),
    );

// ── Shared base ──────────────────────────────────────────────────────────────

class _OnboardingCardScreen extends StatelessWidget {
  const _OnboardingCardScreen({
    required this.currentPage,
    required this.totalPages,
    required this.title,
    required this.body,
    required this.imageBuilder,
    this.showStartButton = false,
    this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final String title;
  final String body;
  final Widget Function() imageBuilder;
  final bool showStartButton;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.surface,
      body: Stack(
        children: [
          // ── Blue accent blob — top-left corner ──────────────────────────
          Positioned(
            top: -30,
            left: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: ShoppeColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Main card ───────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ShoppeSpacing.pagePadding,
                vertical: ShoppeSpacing.base,
              ),
              child: Column(
                children: [
                  // Card
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ShoppeColors.white,
                        borderRadius: BorderRadius.circular(ShoppeRadius.xxl),
                        boxShadow: ShoppeShadows.elevatedShadow,
                      ),
                      child: Column(
                        children: [
                          // Image area — top 55% of card
                          Expanded(
                            flex: 55,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(ShoppeRadius.xxl),
                                topRight: Radius.circular(ShoppeRadius.xxl),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: imageBuilder(),
                              ),
                            ),
                          ),

                          // Text area — bottom 45%
                          Expanded(
                            flex: 45,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: ShoppeSpacing.xl,
                                vertical: ShoppeSpacing.xl,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: ShoppeTypography.headlineLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: ShoppeSpacing.base),
                                  Text(
                                    body,
                                    textAlign: TextAlign.center,
                                    style: ShoppeTypography.bodyLarge.copyWith(
                                      color: ShoppeColors.grey700,
                                      height: 1.6,
                                    ),
                                  ),
                                  if (showStartButton) ...[
                                    const SizedBox(height: ShoppeSpacing.xl),
                                    ShoppeButton(
                                      label: "Let's Start",
                                      onPressed: onNext,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: ShoppeSpacing.xl),

                  // Page dots
                  ShoppePageDots(
                    count: totalPages,
                    current: currentPage,
                  ),

                  const SizedBox(height: ShoppeSpacing.base),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}