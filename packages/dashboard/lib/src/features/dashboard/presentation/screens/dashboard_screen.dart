import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Screen 14 — Full Profile (Activity Dashboard)
/// Scrollable feed with: profile header, announcement, recently viewed,
/// orders, stories, new items, most popular, categories, flash sale,
/// top products, just for you grid, and bottom nav.
class FullProfileScreen extends StatefulWidget {
  const FullProfileScreen({super.key});

  @override
  State<FullProfileScreen> createState() => _FullProfileScreenState();
}

class _FullProfileScreenState extends State<FullProfileScreen> {
  ShoppeNavItem _navItem = ShoppeNavItem.profile;
  int _orderTab = 0;

  // ── Mock data ──────────────────────────────────────────────────────────────

  final List<String> _recentlyViewed = List.generate(5, (_) => '');

  final List<ShoppeStoryData> _stories = [
    const ShoppeStoryData(isLive: true,  showPlay: false),
    const ShoppeStoryData(isLive: false, showPlay: true),
    const ShoppeStoryData(isLive: false, showPlay: true),
    const ShoppeStoryData(isLive: false, showPlay: false),
  ];

  final List<ShoppeProductCardData> _newItems = [
    const ShoppeProductCardData(name: 'Lorem ipsum dolor sit amet consectetur', price: r'$17,00'),
    const ShoppeProductCardData(name: 'Lorem ipsum dolor sit amet consectetur', price: r'$32,00'),
    const ShoppeProductCardData(name: 'Lorem ipsum dolor sit amet consectetur', price: r'$21,00'),
  ];

  final List<({int count, ShoppeTagType tag})> _popular = [
    (count: 1780, tag: ShoppeTagType.newItem),
    (count: 1780, tag: ShoppeTagType.sale),
    (count: 1780, tag: ShoppeTagType.hot),
    (count: 1780, tag: ShoppeTagType.newItem),
  ];

  final List<({String title, int count})> _categories = [
    (title: 'Clothing', count: 109),
    (title: 'Shoes',    count: 530),
    (title: 'Bags',     count: 87),
    (title: 'Lingerie', count: 218),
  ];

  final List<ShoppeProductCardData> _flashSale = List.generate(
    6,
    (_) => const ShoppeProductCardData(
      name: 'Lorem ipsum dolor sit amet consectetur',
      price: r'$16,00',
      originalPrice: r'$20,00',
      discountLabel: '-20%',
    ),
  );

  final List<ShoppeProductCardData> _justForYou = List.generate(
    6,
    (_) => const ShoppeProductCardData(
      name: 'Lorem ipsum dolor sit amet consectetur',
      price: r'$17,00',
    ),
  );

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppeColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.base),

                        // ── Profile header ───────────────────────────────────
                        ShoppeProfileHeader(
                          userName: 'Romina',
                          hasNotification: true,
                          onActivity: () {},
                          onSettings: () {},
                        ),

                        const SizedBox(height: ShoppeSpacing.xl),

                        // ── Greeting ─────────────────────────────────────────
                        Text(
                          'Hello, Romina!',
                          style: ShoppeTypography.headlineLarge,
                        ),

                        const SizedBox(height: ShoppeSpacing.base),

                        // ── Announcement ─────────────────────────────────────
                        ShoppeAnnouncementBanner(
                          body:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              'Maecenas hendrerit luctus libero ac vulputate.',
                          onTap: () {},
                        ),

                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Recently viewed ───────────────────────────────────
                        Text(
                          'Recently viewed',
                          style: ShoppeTypography.headlineMedium,
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                      ]),
                    ),
                  ),

                  // Recently viewed avatars — horizontal scroll
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 68,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: ShoppeSpacing.pagePadding,
                        ),
                        itemCount: _recentlyViewed.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: ShoppeSpacing.sm),
                        itemBuilder: (_, i) => ShoppeAvatar(
                          size: 56,
                          showRing: true,
                          backgroundColor: _avatarColor(i),
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── My Orders ────────────────────────────────────────
                        Text(
                          'My Orders',
                          style: ShoppeTypography.headlineMedium,
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                        ShoppeOrderChips(
                          selected: _orderTab,
                          onChanged: (i) => setState(() => _orderTab = i),
                          notifyIndex: 1,
                        ),

                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Stories ──────────────────────────────────────────
                        Text(
                          'Stories',
                          style: ShoppeTypography.headlineMedium,
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                      ]),
                    ),
                  ),

                  // Stories row — horizontal scroll
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: ShoppeSpacing.pagePadding,
                      ),
                      child: ShoppeStoriesRow(
                        stories: _stories,
                        cardWidth: 138,
                        cardHeight: 190,
                      ),
                    ),
                  ),

                  /* SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── New Items ────────────────────────────────────────
                        ShoppeSectionHeader(
                          title: 'New Items',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                      ]),
                    ),
                  ), */

                  // New items — horizontal scroll
                  /* SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: ShoppeSpacing.pagePadding,
                      ),
                      child: ShoppeProductRow(
                        products: _newItems,
                        cardWidth: 150,
                        height: 230,
                      ),
                    ),
                  ), */

                 /*  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Most Popular ─────────────────────────────────────
                        ShoppeSectionHeader(
                          title: 'Most Popular',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                      ]),
                    ),
                  ), */

                  // Most popular — horizontal avatars
                  /* SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: ShoppeSpacing.pagePadding,
                        ),
                        itemCount: _popular.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: ShoppeSpacing.sm),
                        itemBuilder: (_, i) => ShoppePopularItem(
                          count: _popular[i].count,
                          tagType: _popular[i].tag,
                        ),
                      ),
                    ),
                  ),
 */
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Categories ───────────────────────────────────────
                        ShoppeSectionHeader(
                          title: 'Categories',
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: ShoppeSpacing.base),

                        // 2x2 category grid
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: ShoppeSpacing.cardGap,
                          crossAxisSpacing: ShoppeSpacing.cardGap,
                          childAspectRatio: 1.5,
                          children: _categories
                              .map(
                                (c) => _CategoryTile(
                                  title: c.title,
                                  count: c.count,
                                  color: _categoryColor(c.title),
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Flash Sale ───────────────────────────────────────
                        Row(
                          children: [
                            Text(
                              'Flash Sale',
                              style: ShoppeTypography.headlineMedium,
                            ),
                            const Spacer(),
                            ShoppeFlashSaleTimer(
                              hours: 0,
                              minutes: 36,
                              seconds: 58,
                              borderColor: ShoppeColors.black,
                              textColor: ShoppeColors.black,
                            ),
                          ],
                        ),

                        const SizedBox(height: ShoppeSpacing.base),

                        ShoppeProductGrid(products: _flashSale),

                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Top Products ─────────────────────────────────────
                        Text(
                          'Top Products',
                          style: ShoppeTypography.headlineMedium,
                        ),
                        const SizedBox(height: ShoppeSpacing.base),
                      ]),
                    ),
                  ),

                  // Top products — horizontal circle avatars
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 64,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: ShoppeSpacing.pagePadding,
                        ),
                        itemCount: 5,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: ShoppeSpacing.sm),
                        itemBuilder: (_, i) => ShoppeAvatar(
                          size: 56,
                          showRing: true,
                          backgroundColor: _avatarColor(i + 2),
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShoppeSpacing.pagePadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: ShoppeSpacing.sectionGap),

                        // ── Just For You ─────────────────────────────────────
                        Row(
                          children: [
                            Text(
                              'Just For You',
                              style: ShoppeTypography.headlineMedium,
                            ),
                            const SizedBox(width: ShoppeSpacing.xs),
                            const Icon(
                              Icons.star_rounded,
                              color: ShoppeColors.primary,
                              size: 20,
                            ),
                          ],
                        ),

                        const SizedBox(height: ShoppeSpacing.base),

                        ShoppeProductGrid(products: _justForYou),

                        const SizedBox(height: ShoppeSpacing.xxxl),
                      ]),
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom nav bar ───────────────────────────────────────────────
            /* ShoppeBottomNavBar(
              current: _navItem,
              onChanged: (item) => setState(() => _navItem = item),
            ), */
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  Color _avatarColor(int i) {
    const colors = [
      ShoppeColors.primarySurface,
      Color(0xFFFCE4EC),
      Color(0xFFE8F5E9),
      Color(0xFFFFF8E1),
      Color(0xFFF3E5F5),
    ];
    return colors[i % colors.length];
  }

  Color _categoryColor(String title) {
    return switch (title) {
      'Clothing' => const Color(0xFFFCE4EC),
      'Shoes'    => ShoppeColors.primarySurface,
      'Bags'     => const Color(0xFFFFF8E1),
      'Lingerie' => const Color(0xFFF3E5F5),
      _          => ShoppeColors.surface,
    };
  }
}

// ── Category tile (local molecule for this screen) ──────────────────────────
class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.title,
    required this.count,
    required this.color,
  });

  final String title;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: ShoppeRadius.cardRadius,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ShoppeSpacing.base,
        vertical: ShoppeSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: ShoppeTypography.titleSmall),
          const SizedBox(height: ShoppeSpacing.xs),
          Text('$count items', style: ShoppeTypography.categoryCount),
        ],
      ),
    );
  }
}