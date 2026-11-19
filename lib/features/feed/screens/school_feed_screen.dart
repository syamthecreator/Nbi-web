import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/sidebar_navigation.dart';
import '../../../core/widgets/toast_notification.dart';
import '../providers/feed_provider.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/community_widget.dart';
import '../widgets/feed_search_bar.dart';
import '../widgets/post_card_widget.dart';
import '../widgets/sponsored_store_widget.dart';

/// School Feed Screen - Production architecture using Provider.
class SchoolFeedScreen extends StatelessWidget {
  const SchoolFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTabletOrDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.bgSurface,
      body: Consumer<FeedProvider>(
        builder: (context, feedProvider, _) {
          final posts = feedProvider.filteredPosts;

          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Navigation Sidebar (Desktop & Tablet)
                  if (isTabletOrDesktop)
                    const SidebarNavigation(activeRoute: AppRoutes.schoolFeed),

                  // Center Feed Stream Column
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Header Card
                                Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: AppColors.bgWhite,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.borderLight,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title & Updates Count Badge
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'School Feed',
                                            style: AppTypography.heading1(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.orangeLight,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '${posts.length} ${posts.length == 1 ? 'Update' : 'Updates'}',
                                              style: AppTypography.caption(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryOrange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),

                                      // Search Bar & Filter Chips
                                      if (isDesktop)
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: FeedSearchBar(
                                                feedProvider: feedProvider,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 4,
                                              child: CategoryFilterChips(
                                                feedProvider: feedProvider,
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        Column(
                                          children: [
                                            FeedSearchBar(
                                              feedProvider: feedProvider,
                                            ),
                                            const SizedBox(height: 12),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: CategoryFilterChips(
                                                feedProvider: feedProvider,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),

                        // Posts List
                        if (posts.isEmpty)
                          const SliverToBoxAdapter(child: _EmptyFeedState())
                        else
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    PostCardWidget(post: posts[index]),
                                childCount: posts.length,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Right Sidebar (Community, Sponsored Store Ad) on Desktop
                  if (isDesktop)
                    Container(
                      width: 320,
                      padding: const EdgeInsets.all(20),
                      child: const SingleChildScrollView(
                        child: Column(
                          children: [
                            CommunityWidget(),
                            SizedBox(height: 20),
                            SponsoredStoreWidget(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Toast Notification
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
          ? const MobileBottomNavBar(activeRoute: AppRoutes.schoolFeed)
          : null,
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
