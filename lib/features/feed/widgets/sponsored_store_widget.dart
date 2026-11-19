import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/feed_provider.dart';

class SponsoredStoreWidget extends StatefulWidget {
  const SponsoredStoreWidget({super.key});

  @override
  State<SponsoredStoreWidget> createState() => _SponsoredStoreWidgetState();
}

class _SponsoredStoreWidgetState extends State<SponsoredStoreWidget> {
  bool _isCardHovered = false;
  bool _isPrevArrowHovered = false;
  bool _isNextArrowHovered = false;
  bool _isBtnHovered = false;

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
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, _) {
        if (feedProvider.adSlides.isEmpty) return const SizedBox.shrink();
        final currentSlideIndex = feedProvider.currentAdSlide;
        final slide = feedProvider.adSlides[currentSlideIndex];

        return MouseRegion(
          onEnter: (_) {
            setState(() => _isCardHovered = true);
            feedProvider.stopSlideshow();
          },
          onExit: (_) {
            setState(() => _isCardHovered = false);
            feedProvider.startSlideshow();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: _isCardHovered
                ? Matrix4.translationValues(0, -3, 0)
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x0D000000)),
              boxShadow: [
                BoxShadow(
                  color: _isCardHovered ? const Color(0x12000000) : const Color(0x0A000000),
                  blurRadius: _isCardHovered ? 28 : 24,
                  offset: Offset(0, _isCardHovered ? 10 : 8),
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
                    const Flexible(
                      child: Text(
                        '🔥 SPONSORED STORE',
                        style: TextStyle(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                        style: const TextStyle(
                          color: Color(0xFFD94800),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Media Banner Frame with Dots & Arrows
                Container(
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0x14000000)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Banner Image
                      Positioned.fill(
                        child: AnimatedScale(
                          scale: _isCardHovered ? 1.04 : 1.0,
                          duration: const Duration(milliseconds: 350),
                          curve: const Cubic(0.25, 1, 0.5, 1),
                          child: Image.asset(
                            slide.mediaAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF0F172A),
                              child: const Center(
                                child: Icon(Icons.school, size: 48, color: Colors.white38),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Center Play Button Overlay on Video Slides
                      if (slide.isVideo)
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.45),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      // HD Video Badge on Video Slides (Top Right)
                      if (slide.isVideo)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(10),
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
                                const Text(
                                  'HD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Slide Dots Overlay (Bottom Center)
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(feedProvider.adSlides.length, (idx) {
                            final isDotActive = idx == currentSlideIndex;
                            return GestureDetector(
                              onTap: () => feedProvider.setAdSlide(idx),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                width: isDotActive ? 16 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(isDotActive ? 10 : 3),
                                  color: isDotActive
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.45),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Previous & Next Navigation Arrows (visible on hover)
                      if (_isCardHovered) ...[
                        Positioned(
                          left: 6,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setState(() => _isPrevArrowHovered = true),
                              onExit: (_) => setState(() => _isPrevArrowHovered = false),
                              child: GestureDetector(
                                onTap: feedProvider.prevAdSlide,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isPrevArrowHovered
                                        ? AppColors.primaryOrange
                                        : Colors.white.withValues(alpha: 0.9),
                                    border: Border.all(
                                      color: _isPrevArrowHovered
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
                                      color: _isPrevArrowHovered
                                          ? Colors.white
                                          : const Color(0xFF111111),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) => setState(() => _isNextArrowHovered = true),
                              onExit: (_) => setState(() => _isNextArrowHovered = false),
                              child: GestureDetector(
                                onTap: feedProvider.nextAdSlide,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isNextArrowHovered
                                        ? AppColors.primaryOrange
                                        : Colors.white.withValues(alpha: 0.9),
                                    border: Border.all(
                                      color: _isNextArrowHovered
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
                                      color: _isNextArrowHovered
                                          ? Colors.white
                                          : const Color(0xFF111111),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Ad Content Box
                Text(
                  slide.title,
                  style: AppTypography.heading3(
                    fontSize: 16.3,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  slide.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4B5563),
                    height: 1.48,
                  ),
                ),
                const SizedBox(height: 12),

                // Call To Action Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _isBtnHovered = true),
                  onExit: (_) => setState(() => _isBtnHovered = false),
                  child: GestureDetector(
                    onTap: () {
                      feedProvider.showToast('🛍️ Opening ${slide.actionText}...');
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: _isBtnHovered
                          ? Matrix4.translationValues(0, -1, 0)
                          : Matrix4.identity(),
                      width: double.infinity,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: slide.isVideo
                            ? const LinearGradient(
                                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: slide.isVideo
                                ? const Color(0x330F172A)
                                : const Color(0x40FF5A00),
                            blurRadius: _isBtnHovered ? 18 : 12,
                            offset: Offset(0, _isBtnHovered ? 6 : 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slide.actionText,
                            style: AppTypography.bodyBold(
                              fontSize: 13.7,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            slide.isVideo ? Icons.play_arrow_rounded : Icons.arrow_forward_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
