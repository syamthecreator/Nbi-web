import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../feed/screens/school_feed_screen.dart';

/// Profile Screen - Wrapped in client-approved 3-column layout shell
/// with fixed SidebarNavigation, CommunityWidget, and SponsoredStoreWidget.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SchoolFeedScreen(initialSection: AppRoutes.profile);
  }
}
