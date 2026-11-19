import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nbi_web/app/routes/app_routes.dart';
import 'package:nbi_web/core/widgets/sidebar_navigation.dart';
import 'package:nbi_web/features/auth/providers/auth_provider.dart';
import 'package:nbi_web/features/feed/providers/feed_provider.dart';
import 'package:nbi_web/features/feed/screens/school_feed_screen.dart';
import 'package:nbi_web/features/feed/widgets/community_widget.dart';
import 'package:nbi_web/features/feed/widgets/sponsored_store_widget.dart';
import 'package:nbi_web/features/profile/providers/profile_provider.dart';
import 'package:nbi_web/features/profile/widgets/profile_content.dart';
import 'package:nbi_web/features/settings/providers/settings_provider.dart';
import 'package:nbi_web/features/settings/widgets/settings_content.dart';

void main() {
  group('FeedProvider Tests', () {
    late FeedProvider provider;

    setUp(() {
      provider = FeedProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('Initial state matches source_nbi with 6 posts and 3 ad slides', () {
      expect(provider.posts.length, 6);
      expect(provider.filteredPosts.length, 6);
      expect(provider.adSlides.length, 3);
      expect(provider.selectedCategory, 'all');
      expect(provider.searchQuery, '');
    });

    test('Category filtering filters posts correctly', () {
      provider.setCategory('announcements');
      expect(provider.filteredPosts.length, 2);
      expect(provider.filteredPosts.every((p) => p.category == 'announcements'), true);

      provider.setCategory('homework');
      expect(provider.filteredPosts.length, 2);
      expect(provider.filteredPosts.every((p) => p.category == 'homework'), true);

      provider.setCategory('events');
      expect(provider.filteredPosts.length, 1);
      expect(provider.filteredPosts.first.title, contains('Sports Day'));

      provider.setCategory('fees');
      expect(provider.filteredPosts.length, 1);
      expect(provider.filteredPosts.first.title, contains('Fee Payment'));

      provider.setCategory('all');
      expect(provider.filteredPosts.length, 6);
    });

    test('Search filters posts by title, content, and school name', () {
      provider.setSearchQuery('weather');
      expect(provider.filteredPosts.length, 1);
      expect(provider.filteredPosts.first.id, 'post-1');

      provider.setSearchQuery('Carmel');
      expect(provider.filteredPosts.length, 2);

      provider.clearSearch();
      expect(provider.filteredPosts.length, 6);
    });

    test('Pin post moves it to top and updates toast', () {
      expect(provider.posts.first.id, 'post-1');
      provider.togglePin('post-3');
      expect(provider.posts.first.id, 'post-3');
      expect(provider.posts.first.isPinned, true);
      expect(provider.toastMessage, contains('pinned'));
    });

    test('Toggle like updates like state and count', () {
      final initialLikes = provider.posts.first.likesCount;
      provider.toggleLike('post-1');
      expect(provider.posts.first.isLiked, true);
      expect(provider.posts.first.likesCount, initialLikes + 1);

      provider.toggleLike('post-1');
      expect(provider.posts.first.isLiked, false);
      expect(provider.posts.first.likesCount, initialLikes);
    });

    test('Toggle bookmark updates bookmark state', () {
      expect(provider.posts.first.isBookmarked, false);
      provider.toggleBookmark('post-1');
      expect(provider.posts.first.isBookmarked, true);
    });

    test('Ad slideshow controls navigate slides', () {
      expect(provider.currentAdSlide, 0);
      provider.nextAdSlide();
      expect(provider.currentAdSlide, 1);
      provider.nextAdSlide();
      expect(provider.currentAdSlide, 2);
      provider.nextAdSlide();
      expect(provider.currentAdSlide, 0);

      provider.prevAdSlide();
      expect(provider.currentAdSlide, 2);

      provider.setAdSlide(1);
      expect(provider.currentAdSlide, 1);
    });
  });

  group('SchoolFeedScreen Fixed Sidebars Navigation Test', () {
    testWidgets('SidebarNavigation, CommunityWidget, SponsoredStoreWidget stay fixed when switching sections',
        (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FeedProvider()),
            ChangeNotifierProvider(create: (_) => SettingsProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
          ],
          child: const MaterialApp(
            home: SchoolFeedScreen(initialSection: AppRoutes.schoolFeed),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Left Sidebar and Right Widgets are present in Feed section
      expect(find.byType(SidebarNavigation), findsOneWidget);
      expect(find.byType(CommunityWidget), findsOneWidget);
      expect(find.byType(SponsoredStoreWidget), findsOneWidget);
      expect(find.text('School Feed'), findsNWidgets(2)); // in sidebar + header card

      // Tap Settings in the Sidebar
      final settingsNavBtn = find.text('Settings');
      expect(settingsNavBtn, findsOneWidget);
      await tester.tap(settingsNavBtn);
      await tester.pumpAndSettle();

      // Verify Left Sidebar and Right Widgets are STILL present (FIXED)
      expect(find.byType(SidebarNavigation), findsOneWidget);
      expect(find.byType(CommunityWidget), findsOneWidget);
      expect(find.byType(SponsoredStoreWidget), findsOneWidget);
      // Center now shows Settings content
      expect(find.byType(SettingsContent), findsOneWidget);

      // Tap Profile in the Sidebar
      final profileNavBtn = find.text('Profile');
      expect(profileNavBtn, findsOneWidget);
      await tester.tap(profileNavBtn);
      await tester.pumpAndSettle();

      // Verify Left Sidebar and Right Widgets are STILL present (FIXED)
      expect(find.byType(SidebarNavigation), findsOneWidget);
      expect(find.byType(CommunityWidget), findsOneWidget);
      expect(find.byType(SponsoredStoreWidget), findsOneWidget);
      // Center now shows Profile content
      expect(find.byType(ProfileContent), findsOneWidget);
    });
  });
}
