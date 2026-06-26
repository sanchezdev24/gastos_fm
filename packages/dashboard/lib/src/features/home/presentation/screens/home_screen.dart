import 'package:dashboard/src/features/home/presentation/widgets/transaction_card.dart';
import 'package:design_system/tokens/colors.dart';
import 'package:design_system/tokens/spacing.dart';
import 'package:design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerPadding,
          ).copyWith(top: AppSpacing.md, bottom: AppSpacing.xl),
          children: const [
            _HomeHeader(),
            SizedBox(height: AppSpacing.md),
            _SpendingSummaryCard(
              spent: 255.00,
              limit: 300.00,
              daysUntilNextCycle: 4,
            ),
            SizedBox(height: AppSpacing.md),
            _QuickAddTransactionCard(),
            SizedBox(height: AppSpacing.lg),
            _DailyTransactionsHeader(),
            SizedBox(height: AppSpacing.sm),
            TransactionCard(
              icon: Icons.restaurant,
              iconBackground: Color(0xFFFFE0C2),
              iconColor: Color(0xFF914D00),
              title: 'Food',
              subtitle: 'Grocery & Essentials',
              amount: -150.00,
              time: '12:45 PM',
            ),
            SizedBox(height: AppSpacing.sm),
            TransactionCard(
              icon: Icons.directions_car,
              iconBackground: AppColors.surfaceContainerHigh,
              iconColor: AppColors.primary,
              title: 'Uber',
              subtitle: 'Transport',
              amount: -45.00,
              time: '09:15 AM',
            ),
            SizedBox(height: AppSpacing.sm),
            TransactionCard(
              icon: Icons.coffee,
              iconBackground: Color(0xFFB7F0D6),
              iconColor: AppColors.tertiary,
              title: 'Cafe',
              subtitle: 'Dining out',
              amount: -60.00,
              time: 'Yesterday',
            ),
            SizedBox(height: AppSpacing.sm),
            TransactionCard(
              icon: Icons.shopping_bag_outlined,
              iconBackground: Color(0xFFFFE0C2),
              iconColor: Color(0xFF914D00),
              title: 'Shopping',
              subtitle: 'Misc',
              amount: -32.00,
              time: 'Yesterday',
            ),
            SizedBox(height: AppSpacing.sm),
            TransactionCard(
              icon: Icons.subscriptions_outlined,
              iconBackground: AppColors.surfaceContainerHigh,
              iconColor: AppColors.primary,
              title: 'Netflix',
              subtitle: 'Subcription',
              amount: -14.99,
              time: '3 days ago',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondaryContainer,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'FinanceFlow',
          style: AppTypography.headlineMd.copyWith(color: AppColors.primary),
        ),
        const Spacer(),
        Icon(Icons.notifications_none, color: AppColors.primary, size: 26),
      ],
    );
  }
}

class _SpendingSummaryCard extends StatelessWidget {
  final double spent;
  final double limit;
  final int daysUntilNextCycle;

  const _SpendingSummaryCard({
    required this.spent,
    required this.limit,
    required this.daysUntilNextCycle,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (spent / limit).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24), // rounded-xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TODAY'S TOTAL SPENDING",
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.inversePrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${spent.toStringAsFixed(2)}',
                style: AppTypography.displayLgMobile.copyWith(
                  color: Colors.white,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '/ \$${limit.toStringAsFixed(0)} limit',
                style: AppTypography.bodyLg.copyWith(
                  color: AppColors.inversePrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.inversePrimary,
                size: 16,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$daysUntilNextCycle days until next cycle',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.inversePrimary,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: Colors.white.withOpacity(0.24),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAddTransactionCard extends StatelessWidget {
  const _QuickAddTransactionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK ADD TRANSACTION',
            style: AppTypography.labelCaps.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '\$',
                        style: AppTypography.bodyLg.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '0.00',
                        style: AppTypography.bodyLg.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: AppTypography.bodyLg.copyWith(
                          color: AppColors.onSurface,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Log Expense',
                    style: AppTypography.bodyLg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyTransactionsHeader extends StatelessWidget {
  const _DailyTransactionsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Daily Transactions',
          style: AppTypography.headlineMd.copyWith(color: AppColors.onSurface),
        ),
        Text(
          'VIEW ALL',
          style: AppTypography.labelCaps.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surfaceContainerLowest,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.onSurfaceVariant,
      selectedLabelStyle: AppTypography.bodySm.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTypography.bodySm,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Shared',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Metrics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
