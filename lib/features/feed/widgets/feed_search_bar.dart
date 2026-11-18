import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/feed_provider.dart';

/// Search input pill bar for School Feed.
class FeedSearchBar extends StatelessWidget {
  final FeedProvider feedProvider;

  const FeedSearchBar({super.key, required this.feedProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      child: TextField(
        onChanged: feedProvider.setSearchQuery,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search notices, homework, events...',
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primaryOrange),
          suffixIcon: feedProvider.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                  onPressed: feedProvider.clearSearch,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
