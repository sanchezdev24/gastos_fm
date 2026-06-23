import 'package:flutter/material.dart';
import '../../tokens/shoppe_colors.dart';
import '../../tokens/shoppe_typography.dart';
import '../../tokens/shoppe_tokens.dart';
import '../../atoms/shoppe_atoms.dart';
import '../../molecules/shoppe_molecules.dart';

// ════════════════════════════════════════════════════════════════════════════════
// ORGANISMS — Complex sections / functional blocks.
// ════════════════════════════════════════════════════════════════════════════════

// ─── 1. ShoppeBottomNavBar ───────────────────────────────────────────────────
enum ShoppeNavItem { home, wishlist, orders, cart, profile }

class ShoppeBottomNavBar extends StatelessWidget {
  const ShoppeBottomNavBar({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final ShoppeNavItem current;
  final ValueChanged<ShoppeNavItem> onChanged;

  static const _items = [
    (icon: Icons.home_rounded,              label: 'Home',    item: ShoppeNavItem.home),
    (icon: Icons.favorite_border_rounded,   label: 'Wishlist',item: ShoppeNavItem.wishlist),
    (icon: Icons.list_alt_rounded,          label: 'Orders',  item: ShoppeNavItem.orders),
    (icon: Icons.shopping_bag_outlined,     label: 'Cart',    item: ShoppeNavItem.cart),
    (icon: Icons.person_outline_rounded,    label: 'Profile', item: ShoppeNavItem.profile),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ShoppeColors.white,
        boxShadow: ShoppeShadows.navBarShadow,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _items.map((e) {
              final isActive = e.item == current;
              return GestureDetector(
                onTap: () => onChanged(e.item),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: ShoppeDurations.fast,
                        child: Icon(
                          e.icon,
                          size: ShoppeIconSizes.lg,
                          color: isActive
                              ? ShoppeColors.primary
                              : ShoppeColors.grey500,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(height: 3),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: ShoppeColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── 2. ShoppeHeroSlider ─────────────────────────────────────────────────────
/// Banner carousel at the top of the Shop screen.
class ShoppeHeroSlider extends StatefulWidget {
  const ShoppeHeroSlider({
    super.key,
    required this.banners,
    this.height = 160,
    this.autoPlay = true,
  });

  final List<Widget> banners;
  final double height;
  final bool autoPlay;

  @override
  State<ShoppeHeroSlider> createState() => _ShoppeHeroSliderState();
}

class _ShoppeHeroSliderState extends State<ShoppeHeroSlider> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView(
            controller: _controller,
            onPageChanged: (i) => setState(() => _current = i),
            children: widget.banners,
          ),
        ),
        const SizedBox(height: ShoppeSpacing.sm),
        ShoppePageDots(count: widget.banners.length, current: _current),
      ],
    );
  }
}

// ─── 3. ShoppeProductGrid ────────────────────────────────────────────────────
/// 2-column product grid (Flash Sale products, Just For You, etc.)
class ShoppeProductGrid extends StatelessWidget {
  const ShoppeProductGrid({
    super.key,
    required this.products,
    this.crossAxisCount = 2,
    this.aspectRatio = 0.65,
    this.padding,
  });

  final List<ShoppeProductCardData> products;
  final int crossAxisCount;
  final double aspectRatio;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: ShoppeSpacing.cardGap,
          crossAxisSpacing: ShoppeSpacing.cardGap,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (_, i) {
          final p = products[i];
          return ShoppeProductCard(
            imageUrl: p.imageUrl,
            imageAsset: p.imageAsset,
            name: p.name,
            price: p.price,
            originalPrice: p.originalPrice,
            discountLabel: p.discountLabel,
            onTap: p.onTap,
          );
        },
      ),
    );
  }
}

/// Data model for a product item.
class ShoppeProductCardData {
  const ShoppeProductCardData({
    this.imageUrl,
    this.imageAsset,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discountLabel,
    this.onTap,
  });

  final String? imageUrl;
  final String? imageAsset;
  final String name;
  final String price;
  final String? originalPrice;
  final String? discountLabel;
  final VoidCallback? onTap;
}

// ─── 4. ShoppeProductRow ─────────────────────────────────────────────────────
/// Horizontal scrolling product row (New Items, Top Products).
class ShoppeProductRow extends StatelessWidget {
  const ShoppeProductRow({
    super.key,
    required this.products,
    this.cardWidth = 148,
    this.height = 220,
  });

  final List<ShoppeProductCardData> products;
  final double cardWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: ShoppeSpacing.cardGap),
        itemBuilder: (_, i) {
          final p = products[i];
          return ShoppeProductCard(
            imageUrl: p.imageUrl,
            imageAsset: p.imageAsset,
            name: p.name,
            price: p.price,
            originalPrice: p.originalPrice,
            discountLabel: p.discountLabel,
            onTap: p.onTap,
            width: cardWidth,
          );
        },
      ),
    );
  }
}

// ─── 5. ShoppeFlashSaleSection ───────────────────────────────────────────────
/// Flash sale header (title + timer + discount filter row) + product grid.
class ShoppeFlashSaleSection extends StatefulWidget {
  const ShoppeFlashSaleSection({
    super.key,
    required this.products,
    this.hours = 0,
    this.minutes = 36,
    this.seconds = 58,
  });

  final List<ShoppeProductCardData> products;
  final int hours;
  final int minutes;
  final int seconds;

  @override
  State<ShoppeFlashSaleSection> createState() => _ShoppeFlashSaleSectionState();
}

class _ShoppeFlashSaleSectionState extends State<ShoppeFlashSaleSection> {
  int _selectedFilter = 2; // default "20%"

  static const _filters = ['All', '10%', '20%', '30%', '40%', '50%'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            Text('Flash Sale', style: ShoppeTypography.headlineMedium),
            const Spacer(),
            ShoppeFlashSaleTimer(
              hours: widget.hours,
              minutes: widget.minutes,
              seconds: widget.seconds,
              borderColor: ShoppeColors.black,
              textColor: ShoppeColors.black,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text('Choose Your Discount', style: ShoppeTypography.bodyMedium),
        const SizedBox(height: ShoppeSpacing.base),
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_filters.length, (i) {
              return Padding(
                padding: EdgeInsets.only(right: i < _filters.length - 1 ? 8 : 0),
                child: ShoppeFilterChip(
                  label: _filters[i],
                  isSelected: i == _selectedFilter,
                  onTap: () => setState(() => _selectedFilter = i),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: ShoppeSpacing.base),
        // Section header with filter icon
        Row(
          children: [
            Text(
              '${_filters[_selectedFilter]} Discount',
              style: ShoppeTypography.headlineMedium,
            ),
            const Spacer(),
            const Icon(Icons.tune_rounded, color: ShoppeColors.grey700),
          ],
        ),
        const SizedBox(height: ShoppeSpacing.base),
        ShoppeProductGrid(products: widget.products),
      ],
    );
  }
}

// ─── 6. ShoppeStoriesRow ─────────────────────────────────────────────────────
class ShoppeStoriesRow extends StatelessWidget {
  const ShoppeStoriesRow({
    super.key,
    required this.stories,
    this.cardWidth = 140,
    this.cardHeight = 200,
  });

  final List<ShoppeStoryData> stories;
  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: ShoppeSpacing.sm),
        itemBuilder: (_, i) {
          final s = stories[i];
          return ShoppeStoryCard(
            imageUrl: s.imageUrl,
            isLive: s.isLive,
            showPlay: s.showPlay,
            onTap: s.onTap,
            width: cardWidth,
            height: cardHeight,
          );
        },
      ),
    );
  }
}

class ShoppeStoryData {
  const ShoppeStoryData({
    this.imageUrl,
    this.isLive = false,
    this.showPlay = true,
    this.onTap,
  });

  final String? imageUrl;
  final bool isLive;
  final bool showPlay;
  final VoidCallback? onTap;
}

// ─── 7. ShoppeAuthBackground ─────────────────────────────────────────────────
/// Auth screen template with decorative blobs + centered content.
class ShoppeAuthBackground extends StatelessWidget {
  const ShoppeAuthBackground({
    super.key,
    required this.child,
    this.blobPosition = ShoppeBlobPosition.topLeft,
  });

  final Widget child;
  final ShoppeBlobPosition blobPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: Stack(
        children: [
          // Primary blob
          if (blobPosition == ShoppeBlobPosition.topLeft ||
              blobPosition == ShoppeBlobPosition.both)
            Positioned(
              top: -60,
              left: -40,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  color: ShoppeColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (blobPosition == ShoppeBlobPosition.topRight ||
              blobPosition == ShoppeBlobPosition.both)
            Positioned(
              top: -40,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  color: ShoppeColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          // Light blue secondary blob
          Positioned(
            top: 80,
            left: blobPosition == ShoppeBlobPosition.topLeft ? 60 : -20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: ShoppeColors.primaryLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          SafeArea(child: child),
        ],
      ),
    );
  }
}

enum ShoppeBlobPosition { topLeft, topRight, both }

// ─── 8. ShoppeLiveScreen ────────────────────────────────────────────────────
/// Full-screen live viewer with bottom action bar.
class ShoppeLiveViewerBar extends StatelessWidget {
  const ShoppeLiveViewerBar({
    super.key,
    required this.viewerCount,
    this.onShop,
    this.onFastForward,
  });

  final int viewerCount;
  final VoidCallback? onShop;
  final VoidCallback? onFastForward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ShoppeSpacing.base,
        vertical: ShoppeSpacing.sm,
      ),
      color: ShoppeColors.white,
      child: Row(
        children: [
          const Icon(Icons.remove_red_eye_outlined, size: 20),
          const SizedBox(width: ShoppeSpacing.xs),
          Text('$viewerCount', style: ShoppeTypography.titleMedium),
          const SizedBox(width: ShoppeSpacing.base),
          ShoppeTag(type: ShoppeTagType.live),
          const SizedBox(width: ShoppeSpacing.base),
          IconButton(
            onPressed: onFastForward,
            icon: const Icon(Icons.fast_forward_rounded,
                color: ShoppeColors.primary),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: ShoppeButton(
              label: 'Shop',
              onPressed: onShop,
              height: 48,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 9. ShoppeProfileHeader ─────────────────────────────────────────────────
class ShoppeProfileHeader extends StatelessWidget {
  const ShoppeProfileHeader({
    super.key,
    required this.userName,
    this.avatarUrl,
    this.onActivity,
    this.onSettings,
    this.hasNotification = false,
  });

  final String userName;
  final String? avatarUrl;
  final VoidCallback? onActivity;
  final VoidCallback? onSettings;
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShoppeAvatar(imageUrl: avatarUrl, size: 44, showRing: true),
        const SizedBox(width: ShoppeSpacing.sm),
        // Activity button
        GestureDetector(
          onTap: onActivity,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ShoppeSpacing.base,
              vertical: ShoppeSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: ShoppeColors.primary,
              borderRadius: ShoppeRadius.chipRadius,
            ),
            child: Text('My Activity',
                style: ShoppeTypography.titleSmall
                    .copyWith(color: ShoppeColors.white)),
          ),
        ),
        const Spacer(),
        // Cards icon
        Icon(Icons.credit_card_outlined,
            color: ShoppeColors.grey700, size: ShoppeIconSizes.lg),
        const SizedBox(width: ShoppeSpacing.sm),
        // Menu icon with notification
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.menu_rounded,
                color: ShoppeColors.grey700, size: ShoppeIconSizes.lg),
            if (hasNotification)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ShoppeColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: ShoppeSpacing.sm),
        GestureDetector(
          onTap: onSettings,
          child: Icon(Icons.settings_outlined,
              color: ShoppeColors.grey700, size: ShoppeIconSizes.lg),
        ),
      ],
    );
  }
}

// ─── 10. ShoppeMaxAttemptsDialog ────────────────────────────────────────────
/// Modal shown when maximum OTP attempts are reached.
class ShoppeMaxAttemptsDialog extends StatelessWidget {
  const ShoppeMaxAttemptsDialog({super.key, required this.onOkay});

  final VoidCallback onOkay;

  static Future<void> show(BuildContext context, VoidCallback onOkay) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => ShoppeMaxAttemptsDialog(onOkay: onOkay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: ShoppeRadius.dialogRadius),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You reached out maximum\namount of attempts.\nPlease, try later.',
                  textAlign: TextAlign.center,
                  style: ShoppeTypography.bodyLarge,
                ),
                const SizedBox(height: ShoppeSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ShoppeButton(
                    label: 'Okay',
                    onPressed: onOkay,
                    variant: ShoppeButtonVariant.primary,
                    height: 48,
                  ),
                ),
              ],
            ),
          ),
          // Icon badge
          Positioned(
            top: -28,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: ShoppeColors.errorSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: ShoppeColors.error,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
