import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../models/post_model.dart';
import '../providers/feed_provider.dart';

class PostCardWidget extends StatefulWidget {
  final PostModel post;

  const PostCardWidget({super.key, required this.post});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool _isHovered = false;
  bool _isAttachmentHovered = false;
  bool _isDownloadHovered = false;
  bool _isLikeHovered = false;
  bool _isShareHovered = false;
  bool _isBookmarkHovered = false;
  bool _isMoreHovered = false;

  @override
  Widget build(BuildContext context) {
    final feedProvider = context.read<FeedProvider>();
    final post = widget.post;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: post.isPinned
              ? const Border(
                  left: BorderSide(color: AppColors.primaryOrange, width: 4.5),
                )
              : null,
          gradient: post.isPinned
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFFDFB), Color(0xFFFFFFFF)],
                )
              : null,
          boxShadow: post.isPinned
              ? const [
                  BoxShadow(
                    color: Color(0x14FF5A00),
                    blurRadius: 22,
                    offset: Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: _isHovered
                        ? const Color(0x0D000000)
                        : const Color(0x08000000),
                    blurRadius: _isHovered ? 24 : 18,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Author Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // School Crest Logo Frame
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isHovered
                                ? AppColors.primaryOrange
                                : const Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isHovered
                                  ? const Color(0x26FF5A00)
                                  : const Color(0x0D000000),
                              blurRadius: _isHovered ? 12 : 8,
                              offset: Offset(0, _isHovered ? 4 : 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            post.schoolLogo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.school,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // School Name & Meta
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.schoolName,
                              style: AppTypography.heading3(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111111),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              post.authorMeta,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF777777),
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 3-Dots Popup Menu Button
                MouseRegion(
                  onEnter: (_) => setState(() => _isMoreHovered = true),
                  onExit: (_) => setState(() => _isMoreHovered = false),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isMoreHovered
                          ? const Color(0xFFF3F4F6)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_horiz,
                          color: _isMoreHovered
                              ? const Color(0xFF111111)
                              : const Color(0xFF888888),
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0x14000000),
                            width: 1,
                          ),
                        ),
                        offset: const Offset(0, 36),
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
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Text(
                                  post.isPinned ? '📍' : '📌',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  post.isPinned
                                      ? 'Unpin from Top'
                                      : 'Pin to Top of Feed',
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'copy',
                            height: 38,
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Text('🔗', style: TextStyle(fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  'Copy Notice Link',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'mute',
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Text(
                                  post.isMuted ? '🔔' : '🔕',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  post.isMuted
                                      ? 'Unmute School Alerts'
                                      : 'Mute School Alerts',
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(height: 8),
                          const PopupMenuItem(
                            value: 'report',
                            height: 38,
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Text('🚩', style: TextStyle(fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  'Report Announcement',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFEF4444),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Category Badges & Pinned Badge
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (post.isPinned)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40FF5A00),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      '📌 PINNED ANNOUNCEMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                _buildBadge(post),
              ],
            ),

            const SizedBox(height: 10),

            // Post Title
            Text(
              post.title,
              style: AppTypography.heading2(
                fontSize: 18.8,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),

            // Post Text
            Text(
              post.content,
              style: AppTypography.bodyMedium(
                fontSize: 14.7,
                color: const Color(0xFF4B5563),
              ).copyWith(height: 1.52),
            ),

            // PDF Attachment Card
            if (post.attachmentName != null) ...[
              const SizedBox(height: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isAttachmentHovered = true),
                onExit: (_) => setState(() => _isAttachmentHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _isAttachmentHovered
                        ? const Color(0xFFFFF8F3)
                        : const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _isAttachmentHovered
                          ? const Color(0xFFFFB380)
                          : const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEADF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.description_outlined,
                                color: AppColors.primaryOrange,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.attachmentName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111111),
                                ),
                              ),
                              if (post.attachmentSize != null)
                                Text(
                                  post.attachmentSize!,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => _isDownloadHovered = true),
                        onExit: (_) =>
                            setState(() => _isDownloadHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            feedProvider.showToast(
                              '📥 Downloading ${post.attachmentName}...',
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: _isDownloadHovered
                                ? Matrix4.translationValues(0, -2, 0)
                                : Matrix4.identity(),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isDownloadHovered
                                  ? AppColors.primaryOrange
                                  : Colors.white,
                              border: Border.all(
                                color: _isDownloadHovered
                                    ? AppColors.primaryOrange
                                    : const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: _isDownloadHovered
                                    ? Colors.white
                                    : AppColors.primaryOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 14),

            // Post Footer Action Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Like Action Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => _isLikeHovered = true),
                      onExit: (_) => setState(() => _isLikeHovered = false),
                      child: GestureDetector(
                        onTap: () => feedProvider.toggleLike(post.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: post.isLiked
                                ? const Color(0xFFFFF0E6)
                                : (_isLikeHovered
                                      ? const Color(0xFFFFF5ED)
                                      : Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                post.isLiked
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                                size: 18,
                                color: post.isLiked || _isLikeHovered
                                    ? AppColors.primaryOrange
                                    : const Color(0xFF6B7280),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${post.likesCount}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: post.isLiked
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: post.isLiked || _isLikeHovered
                                      ? AppColors.primaryOrange
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Share Action Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => _isShareHovered = true),
                      onExit: (_) => setState(() => _isShareHovered = false),
                      child: GestureDetector(
                        onTap: () => feedProvider.sharePost(post.title),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _isShareHovered
                                ? const Color(0xFFFFF5ED)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: _isShareHovered
                                ? AppColors.primaryOrange
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Bookmark Action Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _isBookmarkHovered = true),
                  onExit: (_) => setState(() => _isBookmarkHovered = false),
                  child: GestureDetector(
                    onTap: () => feedProvider.toggleBookmark(post.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: post.isBookmarked
                            ? const Color(0xFFFFF0E6)
                            : (_isBookmarkHovered
                                  ? const Color(0xFFFFF5ED)
                                  : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        post.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        size: 20,
                        color: post.isBookmarked || _isBookmarkHovered
                            ? AppColors.primaryOrange
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(PostModel post) {
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        post.badgeText,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
