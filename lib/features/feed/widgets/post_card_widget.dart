import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../models/post_model.dart';
import '../providers/feed_provider.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel post;

  const PostCardWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final feedProvider = context.read<FeedProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: post.isPinned ? AppColors.primaryOrange.withValues(alpha: 0.4) : AppColors.borderLight,
          width: post.isPinned ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 12),
            child: Row(
              children: [
                // School Crest Logo
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(post.schoolLogo, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),

                // School Name & Author Meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.schoolName,
                        style: AppTypography.heading3(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.authorMeta,
                        style: AppTypography.caption(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // 3-Dots Popup Menu
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: AppColors.textMuted),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onSelected: (action) {
                    switch (action) {
                      case 'pin':
                        feedProvider.togglePin(post.id);
                        break;
                      case 'copy':
                        feedProvider.copyPostLink(post.title);
                        break;
                      case 'mute':
                        feedProvider.toggleMute(post.schoolName);
                        break;
                      case 'report':
                        feedProvider.reportPost(post.id);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'pin',
                      child: Row(
                        children: [
                          const Text('📌 '),
                          Text(post.isPinned ? 'Unpin from Top' : 'Pin to Top of Feed'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'copy',
                      child: Row(
                        children: [
                          Text('🔗 '),
                          Text('Copy Notice Link'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'mute',
                      child: Row(
                        children: [
                          Text(post.isMuted ? '🔔 ' : '🔕 '),
                          Text(post.isMuted ? 'Unmute School Alerts' : 'Mute School Alerts'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          Text('🚩 '),
                          Text('Report Announcement', style: TextStyle(color: AppColors.urgentText)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category & Pinned Badges
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: [
                if (post.isPinned)
                  _BadgeTag(
                    text: '📌 PINNED ANNOUNCEMENT',
                    backgroundColor: AppColors.orangeLight,
                    textColor: AppColors.primaryOrange,
                  ),
                _getCategoryBadge(post),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Post Title & Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: AppTypography.heading2(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  post.content,
                  style: AppTypography.bodyMedium(fontSize: 14, color: AppColors.textBody),
                ),
              ],
            ),
          ),

          // Attachment Card (if present)
          if (post.attachmentName != null) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.urgentBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Icon(Icons.picture_as_pdf, color: AppColors.urgentText, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.attachmentName!,
                            style: AppTypography.bodyBold(fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (post.attachmentSize != null)
                            Text(
                              post.attachmentSize!,
                              style: AppTypography.caption(fontSize: 11),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.download_rounded, color: AppColors.primaryOrange),
                      onPressed: () {
                        feedProvider.showToast('📥 Downloading ${post.attachmentName}...');
                      },
                      tooltip: 'Download Attachment',
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.borderLight),

          // Post Footer Actions (Like, Share, Bookmark)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Like Button
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => feedProvider.toggleLike(post.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              post.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              size: 18,
                              color: post.isLiked ? AppColors.primaryOrange : AppColors.textMuted,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${post.likesCount}',
                              style: AppTypography.caption(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: post.isLiked ? AppColors.primaryOrange : AppColors.textBody,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Share Button
                    IconButton(
                      icon: const Icon(Icons.share_outlined, size: 19, color: AppColors.textMuted),
                      onPressed: () => feedProvider.sharePost(post.title),
                      tooltip: 'Share',
                    ),
                  ],
                ),

                // Bookmark Button
                IconButton(
                  icon: Icon(
                    post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 21,
                    color: post.isBookmarked ? AppColors.primaryOrange : AppColors.textMuted,
                  ),
                  onPressed: () => feedProvider.toggleBookmark(post.id),
                  tooltip: 'Bookmark',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCategoryBadge(PostModel post) {
    Color bg;
    Color fg;

    switch (post.badgeType) {
      case 'urgent':
        bg = AppColors.urgentBg;
        fg = AppColors.urgentText;
        break;
      case 'homework':
        bg = AppColors.homeworkBg;
        fg = AppColors.homeworkText;
        break;
      case 'events':
        bg = AppColors.eventsBg;
        fg = AppColors.eventsText;
        break;
      case 'fees':
        bg = AppColors.feesBg;
        fg = AppColors.feesText;
        break;
      case 'announcement':
      default:
        bg = AppColors.announcementBg;
        fg = AppColors.announcementText;
        break;
    }

    return _BadgeTag(
      text: post.badgeText,
      backgroundColor: bg,
      textColor: fg,
    );
  }
}

class _BadgeTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _BadgeTag({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTypography.caption(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
