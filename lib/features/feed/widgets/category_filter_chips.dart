import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/feed_provider.dart';

/// Category Filter Chips for filtering posts in School Feed.
class CategoryFilterChips extends StatelessWidget {
  final FeedProvider feedProvider;

  const CategoryFilterChips({super.key, required this.feedProvider});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'key': 'all', 'label': 'All'},
      {'key': 'announcements', 'label': 'Announcements'},
      {'key': 'homework', 'label': 'Homework'},
      {'key': 'events', 'label': 'Events'},
      {'key': 'fees', 'label': 'Fees'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSelected = feedProvider.selectedCategory == cat['key'];
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => feedProvider.setCategory(cat['key']!),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryOrange : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF5A00).withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              cat['label']!,
              style: AppTypography.caption(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
