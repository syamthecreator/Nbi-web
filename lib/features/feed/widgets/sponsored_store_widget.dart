import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/hover_builder.dart';
import '../providers/feed_provider.dart';
import 'video_ad_player/video_ad_player.dart';

class SponsoredStoreWidget extends StatefulWidget {
  const SponsoredStoreWidget({super.key});

  @override
  State<SponsoredStoreWidget> createState() => _SponsoredStoreWidgetState();
}

class _SponsoredStoreWidgetState extends State<SponsoredStoreWidget> {
  final ValueNotifier<bool> _isCardHovered = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FeedProvider>().startSlideshow();
      }
    });
  }

  @override
  void dispose() {
    _isCardHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, _) {
        if (feedProvider.adSlides.isEmpty) return const SizedBox.shrink();

        final currentSlideIndex = feedProvider.currentAdSlide;
        final slide = feedProvider.adSlides[currentSlideIndex];

        return MouseRegion(
          onEnter: (_) {
            _isCardHovered.value = true;
            feedProvider.stopSlideshow();
          },
          onExit: (_) {
            _isCardHovered.value = false;
            feedProvider.startSlideshow();
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: _isCardHovered,
            builder: (context, isCardHovered, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                transform: isCardHovered
                    ? Matrix4.translationValues(0, -3, 0)
                    : Matrix4.identity(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0x0A000000),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isCardHovered
                          ? const Color(0x12000000)
                          : const Color(0x0A000000),
                      blurRadius: isCardHovered ? 28 : 24,
                      offset: Offset(0, isCardHovered ? 10 : 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Badges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '🔥 SPONSORED STORE',
                            style: GoogleFonts.montserrat(
                              color: AppColors.primaryOrange,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0E6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0x26FF6000),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            slide.discountTag,
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFFD94800),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Media Frame (Video or Image)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            slide.isVideo
                                ? buildVideoAdView(
                                    videoAsset: slide.mediaAsset,
                                    videoId: '${slide.id}',
                                    isPlaying: !isCardHovered,
                                    fallback: Container(
                                      color: const Color(0xFF000000),
                                      child: Image.asset(
                                        slide.id == 1
                                            ? 'assets/images/school_supplies_ad.jpg'
                                            : 'assets/images/school_building_3d_hero.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(color: const Color(0xFF0F172A)),
                                      ),
                                    ),
                                  )
                                : AnimatedScale(
                                    scale: isCardHovered ? 1.04 : 1.0,
                                    duration: const Duration(milliseconds: 350),
                                    curve: const Cubic(0.25, 1, 0.5, 1),
                                    child: Image.asset(
                                      slide.mediaAsset,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                            // Top video badge if video
                            if (slide.isVideo)
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFEF4444),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'HD VIDEO',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            // Glassmorphic Carousel Indicator Dots
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  feedProvider.adSlides.length,
                                  (index) {
                                    final isActive = index == currentSlideIndex;
                                    return GestureDetector(
                                      onTap: () => feedProvider.setAdSlide(index),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                        ),
                                        width: isActive ? 20 : 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: isActive
                                              ? Colors.white
                                              : Colors.white.withValues(alpha: 0.45),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Previous & Next Navigation Arrows (visible on hover)
                            if (isCardHovered) ...[
                              Positioned(
                                left: 6,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: HoverBuilder(
                                    cursor: SystemMouseCursors.click,
                                    builder: (context, isPrevHovered) {
                                      return GestureDetector(
                                        onTap: feedProvider.prevAdSlide,
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isPrevHovered
                                                ? AppColors.primaryOrange
                                                : Colors.white.withValues(alpha: 0.9),
                                            border: Border.all(
                                              color: isPrevHovered
                                                  ? AppColors.primaryOrange
                                                  : const Color(0xFFE5E7EB),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1F000000),
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.chevron_left,
                                              size: 18,
                                              color: isPrevHovered
                                                  ? Colors.white
                                                  : const Color(0xFF111111),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 6,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: HoverBuilder(
                                    cursor: SystemMouseCursors.click,
                                    builder: (context, isNextHovered) {
                                      return GestureDetector(
                                        onTap: feedProvider.nextAdSlide,
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isNextHovered
                                                ? AppColors.primaryOrange
                                                : Colors.white.withValues(alpha: 0.9),
                                            border: Border.all(
                                              color: isNextHovered
                                                  ? AppColors.primaryOrange
                                                  : const Color(0xFFE5E7EB),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1F000000),
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.chevron_right,
                                              size: 18,
                                              color: isNextHovered
                                                  ? Colors.white
                                                  : const Color(0xFF111111),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Title & Description
                    Text(
                      slide.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      slide.description,
                      style: GoogleFonts.inter(
                        fontSize: 13.1,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4B5563),
                        height: 1.48,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Call To Action Button
                    HoverBuilder(
                      cursor: SystemMouseCursors.click,
                      builder: (context, isBtnHovered) {
                        return GestureDetector(
                          onTap: () {
                            feedProvider.showToast(
                              '🛍️ Opening ${slide.actionText}...',
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: isBtnHovered
                                ? Matrix4.translationValues(0, -1, 0)
                                : Matrix4.identity(),
                            width: double.infinity,
                            height: 42,
                            decoration: BoxDecoration(
                              gradient: slide.isVideo
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF1E293B),
                                        Color(0xFF0F172A),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFFFF6000),
                                        Color(0xFFFF4500),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: slide.isVideo
                                      ? const Color(0x330F172A)
                                      : const Color(0x40FF5A00),
                                  blurRadius: isBtnHovered ? 18 : 12,
                                  offset: Offset(0, isBtnHovered ? 6 : 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  slide.actionText,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13.8,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  slide.isVideo
                                      ? Icons.play_arrow_rounded
                                      : Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
