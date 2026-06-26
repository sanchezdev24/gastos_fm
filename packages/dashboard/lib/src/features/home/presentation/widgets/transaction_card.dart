import 'package:design_system/tokens/colors.dart';
import 'package:design_system/tokens/spacing.dart';
import 'package:design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double amount;
  final String time;

  const TransactionCard({
    super.key,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
  });

  bool get _isIncome => amount > 0;

  @override
  Widget build(BuildContext context) {
    final amountColor = _isIncome
        ? AppColors.incomeGreen
        : AppColors.expenseOverBudgetRed;
    final sign = _isIncome ? '+' : '-';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm + AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16), // rounded-lg
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconBackground,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLg.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sign\$${amount.abs().toStringAsFixed(2)}',
                style: AppTypography.numericData.copyWith(color: amountColor),
              ),
              Text(
                time,
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
