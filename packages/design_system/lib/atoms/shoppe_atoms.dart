import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../tokens/shoppe_colors.dart';
import '../tokens/shoppe_typography.dart';
import '../tokens/shoppe_tokens.dart';

// ════════════════════════════════════════════════════════════════════════════════
// ATOMS  — Smallest indivisible UI units.
// ════════════════════════════════════════════════════════════════════════════════

// ─── 1. ShoppeButton ─────────────────────────────────────────────────────────
enum ShoppeButtonVariant { primary, secondary, ghost, danger }

class ShoppeButton extends StatelessWidget {
  const ShoppeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ShoppeButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width = double.infinity,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onPressed;
  final ShoppeButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bgColor = switch (variant) {
      ShoppeButtonVariant.primary   => ShoppeColors.primary,
      ShoppeButtonVariant.secondary => ShoppeColors.sale,
      ShoppeButtonVariant.ghost     => Colors.transparent,
      ShoppeButtonVariant.danger    => ShoppeColors.error,
    };
    final fgColor = variant == ShoppeButtonVariant.ghost
        ? ShoppeColors.grey700
        : ShoppeColors.white;

    final isOutlined = variant == ShoppeButtonVariant.ghost;

    final button = ShadButton(
      onPressed: isLoading ? null : onPressed,
      width: width,
      height: height,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      hoverBackgroundColor: bgColor.withOpacity(0.88),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: fgColor,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: ShoppeSpacing.sm),
                ],
                Text(label, style: ShoppeTypography.buttonLabel.copyWith(color: fgColor)),
              ],
            ),
    );

    if (!isOutlined) return button;

    // Ghost variant: wrap with a border via DecoratedBox
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: ShoppeRadius.buttonRadius,
        border: Border.all(color: ShoppeColors.grey300, width: 1),
      ),
      child: button,
    );
  }
}

// ─── 2. ShoppeIconCircleButton ────────────────────────────────────────────────
/// Blue circle with an arrow icon — "I already have an account →" and "Not you? →".
class ShoppeCircleIconButton extends StatelessWidget {
  const ShoppeCircleIconButton({
    super.key,
    this.icon = Icons.arrow_forward,
    required this.onPressed,
    this.size = 48,
    this.backgroundColor = ShoppeColors.primary,
    this.iconColor = ShoppeColors.white,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: ShoppeShadows.cardShadow,
        ),
        child: Icon(icon, color: iconColor, size: ShoppeIconSizes.base),
      ),
    );
  }
}

// ─── 3. ShoppeTextField ───────────────────────────────────────────────────────
/// Custom input field styled to match the Shoppe design system.
/// Uses native [TextField] + a decorated [Container] to avoid
/// shadcn_ui version-specific API differences.
class ShoppeTextField extends StatefulWidget {
  const ShoppeTextField({
    super.key,
    this.placeholder = '',
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.prefixWidget,
    this.autofocus = false,
  });

  final String placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? prefixWidget;
  final bool autofocus;

  @override
  State<ShoppeTextField> createState() => _ShoppeTextFieldState();
}

class _ShoppeTextFieldState extends State<ShoppeTextField> {
  bool _obscure = true;
  final FocusNode _focus = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _isFocused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ShoppeDurations.fast,
      decoration: BoxDecoration(
        color: ShoppeColors.surface,
        borderRadius: ShoppeRadius.inputRadius,
        border: Border.all(
          color: _isFocused ? ShoppeColors.primary : Colors.transparent,
          width: _isFocused ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          if (widget.prefixWidget != null) ...[
            const SizedBox(width: ShoppeSpacing.base),
            widget.prefixWidget!,
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword && _obscure,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              style: ShoppeTypography.bodyLarge,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: ShoppeTypography.inputHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ShoppeSpacing.base,
                  vertical: ShoppeSpacing.base,
                ),
              ),
            ),
          ),
          if (widget.isPassword) ...[
            GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Padding(
                padding: const EdgeInsets.only(right: ShoppeSpacing.base),
                child: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: ShoppeColors.grey500,
                  size: ShoppeIconSizes.base,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── 4. ShoppePinDot ─────────────────────────────────────────────────────────
/// Single dot in PIN / OTP entry row.
enum ShoppePinDotState { empty, filled, error }

class ShoppePinDot extends StatelessWidget {
  const ShoppePinDot({
    super.key,
    required this.state,
    this.size = 18,
  });

  final ShoppePinDotState state;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      ShoppePinDotState.empty  => ShoppeColors.grey300,
      ShoppePinDotState.filled => ShoppeColors.primary,
      ShoppePinDotState.error  => ShoppeColors.error,
    };

    return AnimatedContainer(
      duration: ShoppeDurations.fast,
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// ─── 5. ShoppePinRow ──────────────────────────────────────────────────────────
/// Full PIN / OTP dot row (4 or 8 dots).
class ShoppePinRow extends StatelessWidget {
  const ShoppePinRow({
    super.key,
    required this.length,
    required this.filled,
    this.hasError = false,
    this.dotSize = 18,
    this.gap = 12,
  });

  final int length;
  final int filled;
  final bool hasError;
  final double dotSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final state = hasError
            ? ShoppePinDotState.error
            : i < filled
                ? ShoppePinDotState.filled
                : ShoppePinDotState.empty;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: gap / 2),
          child: ShoppePinDot(state: state, size: dotSize),
        );
      }),
    );
  }
}

// ─── 6. ShoppeDiscountBadge ───────────────────────────────────────────────────
/// Top-right corner badge on product cards: "-20%".
class ShoppeDiscountBadge extends StatelessWidget {
  const ShoppeDiscountBadge({
    super.key,
    required this.label,
    this.color = ShoppeColors.badgeDiscount,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: ShoppeRadius.badgeRadius,
      ),
      child: Text(label, style: ShoppeTypography.badgeLabel),
    );
  }
}

// ─── 7. ShoppeTag ────────────────────────────────────────────────────────────
/// Inline tag chips: "New", "Sale", "Hot", "Live".
enum ShoppeTagType { live, newItem, sale, hot }

class ShoppeTag extends StatelessWidget {
  const ShoppeTag({super.key, required this.type});

  final ShoppeTagType type;

  String get _label => switch (type) {
        ShoppeTagType.live    => 'Live',
        ShoppeTagType.newItem => 'New',
        ShoppeTagType.sale    => 'Sale',
        ShoppeTagType.hot     => 'Hot',
      };

  Color get _color => switch (type) {
        ShoppeTagType.live    => ShoppeColors.success,
        ShoppeTagType.newItem => ShoppeColors.badgeNew,
        ShoppeTagType.sale    => ShoppeColors.badgeSale,
        ShoppeTagType.hot     => ShoppeColors.badgeHot,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: ShoppeRadius.chipRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == ShoppeTagType.live) ...[
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(right: 4),
              decoration: const BoxDecoration(
                color: ShoppeColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
          Text(_label, style: ShoppeTypography.badgeLabel),
        ],
      ),
    );
  }
}

// ─── 8. ShoppeAvatar ─────────────────────────────────────────────────────────
/// Circular avatar with optional white ring.
class ShoppeAvatar extends StatelessWidget {
  const ShoppeAvatar({
    super.key,
    this.imageUrl,
    this.imageAsset,
    this.size = 56,
    this.showRing = false,
    this.ringColor = ShoppeColors.white,
    this.ringWidth = 3,
    this.backgroundColor = ShoppeColors.primarySurface,
    this.child,
  });

  final String? imageUrl;
  final String? imageAsset;
  final double size;
  final bool showRing;
  final Color ringColor;
  final double ringWidth;
  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final inner = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : imageAsset != null
                ? DecorationImage(
                    image: AssetImage(imageAsset!),
                    fit: BoxFit.cover,
                  )
                : null,
      ),
      child: (imageUrl == null && imageAsset == null) ? child : null,
    );

    if (!showRing) return inner;

    return Container(
      width: size + ringWidth * 2,
      height: size + ringWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ringColor,
        boxShadow: ShoppeShadows.elevatedShadow,
      ),
      child: Center(child: inner),
    );
  }
}

// ─── 9. ShoppeChip (Filter) ───────────────────────────────────────────────────
/// Discount filter chip: "All", "10%", "20%"...
class ShoppeFilterChip extends StatelessWidget {
  const ShoppeFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: ShoppeDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: ShoppeSpacing.base,
          vertical: ShoppeSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ShoppeColors.primary : Colors.transparent,
          borderRadius: ShoppeRadius.chipRadius,
          border: Border.all(
            color: isSelected ? ShoppeColors.primary : ShoppeColors.grey300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: ShoppeTypography.titleMedium.copyWith(
            color: isSelected ? ShoppeColors.white : ShoppeColors.black,
          ),
        ),
      ),
    );
  }
}

// ─── 10. ShoppePageIndicatorDot ───────────────────────────────────────────────
/// Dot indicator for carousels / onboarding.
class ShoppePageDots extends StatelessWidget {
  const ShoppePageDots({
    super.key,
    required this.count,
    required this.current,
    this.activeDotWidth = 24,
  });

  final int count;
  final int current;
  final double activeDotWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: ShoppeDurations.normal,
          curve: ShoppeCurves.standard,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? activeDotWidth : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? ShoppeColors.primary : ShoppeColors.grey300,
            borderRadius: BorderRadius.circular(ShoppeRadius.full),
          ),
        );
      }),
    );
  }
}

// ─── 11. ShoppeDivider ────────────────────────────────────────────────────────
class ShoppeDivider extends StatelessWidget {
  const ShoppeDivider({super.key, this.horizontal = true});
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: horizontal ? double.infinity : 1,
      height: horizontal ? 1 : double.infinity,
      color: ShoppeColors.grey300,
    );
  }
}

// ─── 12. ShoppeDecorativeBlob ─────────────────────────────────────────────────
/// The organic blue blobs used as background decor on auth screens.
class ShoppeDecorativeBlob extends StatelessWidget {
  const ShoppeDecorativeBlob({
    super.key,
    this.color = ShoppeColors.primary,
    this.size = 280,
    this.alignment = Alignment.topRight,
  });

  final Color color;
  final double size;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(999),
            bottomLeft: const Radius.circular(999),
            bottomRight: const Radius.circular(999),
            topRight: Radius.circular(size * 0.3),
          ),
        ),
      ),
    );
  }
}