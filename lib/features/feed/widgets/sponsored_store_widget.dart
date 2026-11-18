import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/feed_provider.dart';

class SponsoredStoreWidget extends StatelessWidget {
  const SponsoredStoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<FeedProvider>().startSlideshow();
      }
    });

    return Consumer<FeedProvider>(
      builder: (context, feedProvider, _) {
        if (feedProvider.adSlides.isEmpty) return const SizedBox.shrink();
        final currentSlideIndex = feedProvider.currentAdSlide;
        final slide = feedProvider.adSlides[currentSlideIndex];

        return Container(
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
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Badges
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🔥 SPONSORED STORE',
                      style: AppTypography.caption(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.urgentBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        slide.discountTag,
                        style: AppTypography.caption(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.urgentText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Media Banner Frame with Dots & Arrows
              Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.grey.shade900,
                    child: Image.asset(
                      slide.mediaAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(Icons.school, size: 48, color: Colors.white54),
                        ),
                      ),
                    ),
                  ),

                  // HD Video or Tag Badge
                  if (slide.isVideo)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'HD VIDEO',
                              style: AppTypography.caption(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Slide Dots Indicator Overlay
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(feedProvider.adSlides.length, (idx) {
                        final isDotActive = idx == currentSlideIndex;
                        return InkWell(
                          onTap: () => feedProvider.setAdSlide(idx),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isDotActive ? 18 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: isDotActive ? AppColors.primaryOrange : Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Left & Right Navigation Arrows
                  Positioned(
                    left: 6,
                    top: 60,
                    child: _CarouselArrow(
                      icon: Icons.chevron_left,
                      onTap: feedProvider.prevAdSlide,
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 60,
                    child: _CarouselArrow(
                      icon: Icons.chevron_right,
                      onTap: feedProvider.nextAdSlide,
                    ),
                  ),
                ],
              ),

              // Content Details & Call to Action Button
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slide.title,
                      style: AppTypography.heading3(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      slide.description,
                      style: AppTypography.caption(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          feedProvider.showToast('🛍️ Opening store portal...');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              slide.actionText,
                              style: AppTypography.caption(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward_rounded, size: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CarouselArrow({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
