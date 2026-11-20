import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/hover_builder.dart';
import '../providers/feed_provider.dart';

/// Category Filter Chips for filtering posts in School Feed.
class CategoryFilterChips extends StatelessWidget {
  final FeedProvider feedProvider;

  const CategoryFilterChips({super.key, required this.feedProvider});

  @override
  Widget build(BuildContext context) {
    const categories = [
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
        return _FilterChipItem(
          label: cat['label']!,
          isSelected: isSelected,
          onTap: () => feedProvider.setCategory(cat['key']!),
        );
      }).toList(),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, isHovered) {
        final bool active = isSelected;
        final Color bgColor = active
            ? AppColors.primaryOrange
            : (isHovered ? const Color(0xFFE5E7EB) : const Color(0xFFF2F3F5));
        final Color textColor = active
            ? Colors.white
            : (isHovered ? const Color(0xFF111111) : const Color(0xFF555555));

        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: isHovered && !active
                ? Matrix4.translationValues(0, -1, 0)
                : Matrix4.identity(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: active
                  ? const [
                      BoxShadow(
                        color: Color(0x47FF5A00),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              label,
              style: AppTypography.bodyMedium(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
