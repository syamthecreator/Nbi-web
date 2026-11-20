import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/sidebar_navigation.dart';
import '../../../core/widgets/toast_notification.dart';
import '../../profile/widgets/profile_content.dart';
import '../../settings/widgets/settings_content.dart';
import '../providers/feed_provider.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/community_widget.dart';
import '../widgets/feed_search_bar.dart';
import '../widgets/post_card_widget.dart';
import '../widgets/sponsored_store_widget.dart';

/// School Feed Screen - Pixel-perfect match for client-approved source_nbi reference.
/// Left SidebarNavigation and Right CommunityWidget & SponsoredStoreWidget remain
/// strictly fixed across navigation between School Feed, Settings, and Profile.
class SchoolFeedScreen extends StatelessWidget {
  final String initialSection;

  const SchoolFeedScreen({
    super.key,
    this.initialSection = AppRoutes.schoolFeed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 992;
    final isWideDesktop = size.width > 1180;
    final isTabletOrDesktop = size.width > 768;

    final double horizontalPadding = isWideDesktop ? 32 : (isDesktop ? 14 : 16);
    final double verticalPadding = isWideDesktop ? 24 : 16;
    final double columnGap = isWideDesktop ? 24 : 16;
    final double sidebarWidth = isWideDesktop ? 280 : 200;
    final double rightSidebarWidth = isWideDesktop ? 330 : 270;

    return Scaffold(
      backgroundColor: AppColors.feedBg,
      body: Consumer<FeedProvider>(
        builder: (context, feedProvider, _) {
          final activeSection =
              initialSection != AppRoutes.schoolFeed &&
                      feedProvider.activeSection == AppRoutes.schoolFeed
                  ? initialSection
                  : feedProvider.activeSection;

          return Stack(
            children: [
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(scrollbars: false),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT SIDEBAR NAVIGATION (Desktop & Tablet - Fixed)
                      if (isTabletOrDesktop) ...[
                        SizedBox(
                          height: double.infinity,
                          child: SidebarNavigation(
                            activeRoute: activeSection,
                            width: sidebarWidth,
                            onRouteSelected: (route) {
                              feedProvider.setActiveSection(route);
                            },
                          ),
                        ),
                        SizedBox(width: columnGap),
                      ],

                      // CENTER MAIN CONTENT COLUMN (Dynamic Details based on Selection)
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: _buildCenterContent(
                            context,
                            activeSection,
                            feedProvider,
                            isDesktop,
                          ),
                        ),
                      ),

                      // RIGHT SIDEBAR (Desktop only - Fixed Community & Sponsored Store)
                      if (isDesktop) ...[
                        SizedBox(width: columnGap),
                        SizedBox(
                          width: rightSidebarWidth,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const CommunityWidget(),
                                const SizedBox(height: 20),
                                const SponsoredStoreWidget(),
                                SizedBox(height: verticalPadding),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Toast Alert Notification (Bottom Right)
              if (feedProvider.toastMessage != null)
                ToastNotification(
                  message: feedProvider.toastMessage!,
                  onDismiss: feedProvider.clearToast,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: !isTabletOrDesktop
          ? Consumer<FeedProvider>(
              builder: (context, feedProvider, _) {
                final activeSection =
                    initialSection != AppRoutes.schoolFeed &&
                            feedProvider.activeSection == AppRoutes.schoolFeed
                        ? initialSection
                        : feedProvider.activeSection;
                return MobileBottomNavBar(
                  activeRoute: activeSection,
                  onRouteSelected: (route) {
                    feedProvider.setActiveSection(route);
                  },
                );
              },
            )
          : null,
    );
  }

  Widget _buildCenterContent(
    BuildContext context,
    String activeSection,
    FeedProvider feedProvider,
    bool isDesktop,
  ) {
    switch (activeSection) {
      case AppRoutes.settings:
        return const SettingsContent();
      case AppRoutes.profile:
        return const ProfileContent();
      case AppRoutes.schoolFeed:
      default:
        return _buildFeedStream(context, feedProvider, isDesktop);
    }
  }

  Widget _buildFeedStream(
    BuildContext context,
    FeedProvider feedProvider,
    bool isDesktop,
  ) {
    final posts = feedProvider.filteredPosts;

    return Column(
      children: [
        // FIXED header card (does not scroll)
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0x0A000000), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'School Feed',
                    style: AppTypography.heading1(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x1AFF5A00),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${posts.length} ${posts.length == 1 ? 'Update' : 'Updates'}',
                      style: const TextStyle(
                        color: AppColors.primaryOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 760) {
                    return Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 360,
                            minWidth: 200,
                          ),
                          child: FeedSearchBar(feedProvider: feedProvider),
                        ),
                        const Spacer(),
                        CategoryFilterChips(feedProvider: feedProvider),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FeedSearchBar(feedProvider: feedProvider),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: CategoryFilterChips(
                            feedProvider: feedProvider,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),

        // SCROLLABLE posts only
        Expanded(
          child: posts.isEmpty
              ? const SingleChildScrollView(child: _EmptyFeedState())
              : LayoutBuilder(
                  builder: (context, c) => OverflowBox(
                    maxWidth: c.maxWidth + 40,
                    child: SizedBox(
                      width: c.maxWidth + 40,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: posts.length,
                        itemBuilder: (context, index) =>
                            PostCardWidget(post: posts[index]),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _EmptyFeedState extends StatelessWidget {
  const _EmptyFeedState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            const Text('🔍', style: TextStyle(fontSize: 44)),
            const SizedBox(height: 12),
            Text(
              'No Notices Found',
              style: AppTypography.heading2(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              'No announcements match your search or selected filter.',
              style: AppTypography.subtitle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
