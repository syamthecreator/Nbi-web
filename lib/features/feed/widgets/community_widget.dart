import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/feed_provider.dart';

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final feedProvider = context.read<FeedProvider>();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join NBI Community',
            style: AppTypography.heading3(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Stay connected with live school notifications & exam updates.',
            style: AppTypography.caption(fontSize: 12),
          ),
          const SizedBox(height: 16),

          // WhatsApp Channel
          _SocialPill(
            iconEmoji: '💬',
            title: 'WhatsApp Channel',
            subtitle: '50k+ Members',
            actionText: 'Join',
            actionColor: AppColors.whatsappGreen,
            onTap: () => feedProvider.showToast('🚀 Joining WhatsApp Channel...'),
          ),
          const SizedBox(height: 10),

          // Telegram
          _SocialPill(
            iconEmoji: '✈️',
            title: 'Telegram Updates',
            subtitle: 'Instant Alerts',
            actionText: 'Join',
            actionColor: AppColors.telegramBlue,
            onTap: () => feedProvider.showToast('🚀 Opening Telegram Channel...'),
          ),
          const SizedBox(height: 10),

          // Instagram
          _SocialPill(
            iconEmoji: '📸',
            title: 'Instagram',
            subtitle: '@NoticeBoardIndia',
            actionText: 'Follow',
            actionColor: AppColors.instagramPurple,
            onTap: () => feedProvider.showToast('📸 Visiting Instagram Page...'),
          ),
        ],
      ),
    );
  }
}

class _SocialPill extends StatelessWidget {
  final String iconEmoji;
  final String title;
  final String subtitle;
  final String actionText;
  final Color actionColor;
  final VoidCallback onTap;

  const _SocialPill({
    required this.iconEmoji,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.actionColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(iconEmoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyBold(fontSize: 13),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.caption(fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: actionColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                actionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
