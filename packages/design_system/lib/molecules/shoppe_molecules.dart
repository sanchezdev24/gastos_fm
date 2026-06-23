import 'package:flutter/material.dart';
import '../../tokens/shoppe_colors.dart';
import '../../tokens/shoppe_typography.dart';
import '../../tokens/shoppe_tokens.dart';
import '../../atoms/shoppe_atoms.dart';

// ════════════════════════════════════════════════════════════════════════════════
// MOLECULES  — Composed from atoms, with their own logic.
// ════════════════════════════════════════════════════════════════════════════════

// ─── 1. ShoppeProductCard ────────────────────────────────────────────────────
/// Vertical product card with optional discount badge, name, price, original.
class ShoppeProductCard extends StatelessWidget {
  const ShoppeProductCard({
    super.key,
    this.imageUrl,
    this.imageAsset,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discountLabel,
    this.onTap,
    this.width = 160,
  });

  final String? imageUrl;
  final String? imageAsset;
  final String name;
  final String price;
  final String? originalPrice;
  final String? discountLabel;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: ShoppeColors.white,
          borderRadius: ShoppeRadius.cardRadius,
          boxShadow: ShoppeShadows.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image + badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(ShoppeRadius.md),
                    topRight: Radius.circular(ShoppeRadius.md),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImage(),
                  ),
                ),
                if (discountLabel != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ShoppeDiscountBadge(label: discountLabel!),
                  ),
              ],
            ),
            // Text info
            Padding(
              padding: const EdgeInsets.all(ShoppeSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: ShoppeTypography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: ShoppeSpacing.xs),
                  ShoppePriceDisplay(
                    price: price,
                    originalPrice: originalPrice,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl != null) {
      return Image.network(imageUrl!, fit: BoxFit.cover);
    }
    if (imageAsset != null) {
      return Image.asset(imageAsset!, fit: BoxFit.cover);
    }
    return Container(
      color: ShoppeColors.primarySurface,
      child: const Icon(Icons.image_outlined, color: ShoppeColors.grey500),
    );
  }
}

// ─── 2. ShoppePriceDisplay ───────────────────────────────────────────────────
class ShoppePriceDisplay extends StatelessWidget {
  const ShoppePriceDisplay({
    super.key,
    required this.price,
    this.originalPrice,
  });

  final String price;
  final String? originalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(price, style: ShoppeTypography.priceCurrent),
        if (originalPrice != null) ...[
          const SizedBox(width: ShoppeSpacing.xs),
          Text(originalPrice!, style: ShoppeTypography.priceOriginal),
        ],
      ],
    );
  }
}

// ─── 3. ShoppeCategoryCard ───────────────────────────────────────────────────
/// 2×2 image grid with category name + item count below.
class ShoppeCategoryCard extends StatelessWidget {
  const ShoppeCategoryCard({
    super.key,
    required this.title,
    required this.count,
    required this.images,   // up to 4 image urls
    this.onTap,
    this.width = 160,
  });

  final String title;
  final int count;
  final List<String> images;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: ShoppeRadius.cardRadius,
              child: SizedBox(
                height: width,
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: List.generate(4, (i) {
                    if (i < images.length) {
                      return Image.network(images[i], fit: BoxFit.cover);
                    }
                    return Container(color: ShoppeColors.grey100);
                  }),
                ),
              ),
            ),
            const SizedBox(height: ShoppeSpacing.xs),
            Row(
              children: [
                Text(title, style: ShoppeTypography.titleSmall),
                const Spacer(),
                Text('$count', style: ShoppeTypography.categoryCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 4. ShoppeFlashSaleTimer ─────────────────────────────────────────────────
/// Countdown timer widget: "⏱ 00 36 58" with white-bordered digit boxes.
class ShoppeFlashSaleTimer extends StatelessWidget {
  const ShoppeFlashSaleTimer({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
    this.boxColor = Colors.transparent,
    this.textColor = ShoppeColors.white,
    this.borderColor = ShoppeColors.white,
  });

  final int hours;
  final int minutes;
  final int seconds;
  final Color boxColor;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, color: textColor, size: 18),
        const SizedBox(width: ShoppeSpacing.sm),
        _TimerBox(value: hours,   color: boxColor, textColor: textColor, borderColor: borderColor),
        const SizedBox(width: 4),
        _TimerBox(value: minutes, color: boxColor, textColor: textColor, borderColor: borderColor),
        const SizedBox(width: 4),
        _TimerBox(value: seconds, color: boxColor, textColor: textColor, borderColor: borderColor),
      ],
    );
  }
}

class _TimerBox extends StatelessWidget {
  const _TimerBox({
    required this.value,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });

  final int value;
  final Color color;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(ShoppeRadius.sm),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString().padLeft(2, '0'),
        style: ShoppeTypography.timerDigit.copyWith(color: textColor),
      ),
    );
  }
}

// ─── 5. ShoppePopularItem ────────────────────────────────────────────────────
/// Horizontal scroll item in "Most Popular": avatar + count + tag.
class ShoppePopularItem extends StatelessWidget {
  const ShoppePopularItem({
    super.key,
    this.imageUrl,
    required this.count,
    required this.tagType,
    this.onTap,
    this.size = 64,
  });

  final String? imageUrl;
  final int count;
  final ShoppeTagType tagType;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size + 8,
        child: Column(
          children: [
            ShoppeAvatar(
              imageUrl: imageUrl,
              size: size,
              showRing: true,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$count', style: ShoppeTypography.bodySmall),
                const SizedBox(width: 3),
                Icon(Icons.favorite, color: ShoppeColors.error, size: 10),
              ],
            ),
            const SizedBox(height: 2),
            ShoppeTag(type: tagType),
          ],
        ),
      ),
    );
  }
}

// ─── 6. ShoppeStoryCard ───────────────────────────────────────────────────────
/// Tall story card with optional Live badge and play button.
class ShoppeStoryCard extends StatelessWidget {
  const ShoppeStoryCard({
    super.key,
    this.imageUrl,
    this.isLive = false,
    this.showPlay = true,
    this.onTap,
    this.width = 140,
    this.height = 200,
  });

  final String? imageUrl;
  final bool isLive;
  final bool showPlay;
  final VoidCallback? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: ShoppeRadius.storyCardRadius,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              if (imageUrl != null)
                Image.network(imageUrl!, fit: BoxFit.cover)
              else
                Container(color: ShoppeColors.primarySurface),
              // Gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0x66000000)],
                  ),
                ),
              ),
              // Live badge
              if (isLive)
                const Positioned(
                  top: ShoppeSpacing.sm,
                  left: ShoppeSpacing.sm,
                  child: ShoppeTag(type: ShoppeTagType.live),
                ),
              // Play button
              if (showPlay && !isLive)
                Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ShoppeColors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: ShoppeColors.primary,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── 7. ShoppeSectionHeader ──────────────────────────────────────────────────
/// "Top Products" + "See All →" row header for sections.
class ShoppeSectionHeader extends StatelessWidget {
  const ShoppeSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.trailing,
  });

  final String title;
  final VoidCallback? onSeeAll;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: ShoppeTypography.headlineMedium),
        const Spacer(),
        trailing ??
            (onSeeAll != null
                ? GestureDetector(
                    onTap: onSeeAll,
                    child: Row(
                      children: [
                        Text('See All', style: ShoppeTypography.seeAll),
                        const SizedBox(width: ShoppeSpacing.xs),
                        ShoppeCircleIconButton(
                          onPressed: onSeeAll,
                          size: 28,
                          icon: Icons.arrow_forward,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()),
      ],
    );
  }
}

// ─── 8. ShoppeAnnouncementBanner ─────────────────────────────────────────────
/// Grey announcement card on the profile/activity screen.
class ShoppeAnnouncementBanner extends StatelessWidget {
  const ShoppeAnnouncementBanner({
    super.key,
    required this.body,
    this.onTap,
  });

  final String body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ShoppeSpacing.base),
      decoration: BoxDecoration(
        color: ShoppeColors.surface,
        borderRadius: ShoppeRadius.cardRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Announcement', style: ShoppeTypography.announcementTitle),
                const SizedBox(height: 4),
                Text(body,
                    style: ShoppeTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: ShoppeSpacing.sm),
          ShoppeCircleIconButton(onPressed: onTap, size: 36),
        ],
      ),
    );
  }
}

// ─── 9. ShoppeOrderChips ─────────────────────────────────────────────────────
/// "To Pay", "To Receive", "To Review" chip row with optional notification dot.
class ShoppeOrderChips extends StatelessWidget {
  const ShoppeOrderChips({
    super.key,
    required this.selected,
    required this.onChanged,
    this.notifyIndex,
  });

  final int selected;
  final ValueChanged<int> onChanged;
  final int? notifyIndex;   // index with the green notification dot

  static const _labels = ['To Pay', 'To Receive', 'To Review'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(right: ShoppeSpacing.sm),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ShoppeFilterChip(
                label: _labels[i],
                isSelected: i == selected,
                onTap: () => onChanged(i),
              ),
              if (i == notifyIndex)
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: ShoppeColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

// ─── 10. ShoppeRecoveryOption ────────────────────────────────────────────────
/// SMS / Email option tile in Password Recovery screen.
class ShoppeRecoveryOption extends StatelessWidget {
  const ShoppeRecoveryOption({
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
          horizontal: ShoppeSpacing.xl,
          vertical: ShoppeSpacing.base,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ShoppeColors.primarySurface : const Color(0xFFFCEBEE),
          borderRadius: ShoppeRadius.chipRadius,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: ShoppeTypography.titleMedium.copyWith(
                  color: isSelected ? ShoppeColors.primary : ShoppeColors.black,
                ),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? ShoppeColors.primary : ShoppeColors.sale.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: ShoppeColors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 11. ShoppeSearchBar ────────────────────────────────────────────────────
class ShoppeSearchBar extends StatelessWidget {
  const ShoppeSearchBar({
    super.key,
    this.placeholder = 'Search',
    this.onChanged,
    this.trailing,
  });

  final String placeholder;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: ShoppeColors.surface,
        borderRadius: ShoppeRadius.chipRadius,
      ),
      child: Row(
        children: [
          const SizedBox(width: ShoppeSpacing.base),
          const Icon(Icons.search, color: ShoppeColors.grey500, size: 20),
          const SizedBox(width: ShoppeSpacing.sm),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: ShoppeTypography.inputHint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: ShoppeTypography.bodyMedium,
            ),
          ),
          if (trailing != null) ...[
            trailing!,
            const SizedBox(width: ShoppeSpacing.sm),
          ],
        ],
      ),
    );
  }
}

// ─── 12. ShoppePromoBanner ───────────────────────────────────────────────────
/// "Big Sale — Up to 50% — Happening Now" yellow/blue hero banner.
class ShoppePromoBanner extends StatelessWidget {
  const ShoppePromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.cta = 'Happening Now',
    this.imageUrl,
    this.onTap,
    this.height = 140,
  });

  final String title;
  final String subtitle;
  final String cta;
  final String? imageUrl;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: ShoppeRadius.heroBannerRadius,
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ShoppeColors.promo, Color(0xFFFFD54F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Stack(
            children: [
              // Blue circle accent
              Positioned(
                right: -20,
                bottom: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: ShoppeColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              if (imageUrl != null)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.network(imageUrl!, fit: BoxFit.cover, width: 140),
                ),
              Padding(
                padding: const EdgeInsets.all(ShoppeSpacing.base),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: ShoppeTypography.headlineMedium
                            .copyWith(color: ShoppeColors.white)),
                    Text(subtitle,
                        style: ShoppeTypography.bodySmall
                            .copyWith(color: ShoppeColors.white.withOpacity(0.9))),
                    const SizedBox(height: ShoppeSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ShoppeSpacing.sm, vertical: 4),
                      decoration: BoxDecoration(
                        color: ShoppeColors.primary,
                        borderRadius: ShoppeRadius.chipRadius,
                      ),
                      child: Text(cta,
                          style: ShoppeTypography.badgeLabel
                              .copyWith(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
