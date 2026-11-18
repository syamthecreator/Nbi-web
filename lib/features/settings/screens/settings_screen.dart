import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/sidebar_navigation.dart';
import '../../../core/widgets/toast_notification.dart';
import '../../feed/widgets/community_widget.dart';
import '../../feed/widgets/sponsored_store_widget.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_toggle_tile.dart';

/// Settings Screen - Production architecture using Provider.
/// Pure Stateless architecture with Provider. Zero setState().
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTabletOrDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.bgSurface,
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          final activeTab = settingsProvider.activeTab;

          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Navigation Sidebar
                  if (isTabletOrDesktop)
                    const SidebarNavigation(activeRoute: AppRoutes.settings),

                  // Center Content Column
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 860),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Header Card with Tabs
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.bgWhite,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.borderLight),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Settings & Preferences',
                                      style: AppTypography.heading1(fontSize: 22),
                                    ),
                                    const SizedBox(height: 16),

                                    // Category Tabs
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        _TabButton(
                                          title: 'All Settings',
                                          isActive: activeTab == 'all',
                                          onTap: () => settingsProvider.setActiveTab('all'),
                                        ),
                                        _TabButton(
                                          title: 'Notification Preferences',
                                          isActive: activeTab == 'notifications',
                                          onTap: () => settingsProvider.setActiveTab('notifications'),
                                        ),
                                        _TabButton(
                                          title: 'Privacy & Security',
                                          isActive: activeTab == 'security',
                                          onTap: () => settingsProvider.setActiveTab('security'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // SECTION 1: Notification Preferences
                              if (activeTab == 'all' || activeTab == 'notifications') ...[
                                _SectionCard(
                                  iconEmoji: '🔔',
                                  title: 'Notification Alerts & Channels',
                                  subtitle: 'Choose how and when you want to receive school notifications',
                                  children: [
                                    SettingsToggleTile(
                                      title: 'Push Notifications',
                                      subtitle: 'Receive real-time push alerts for school announcements',
                                      value: settingsProvider.settings.pushNotifications,
                                      onChanged: settingsProvider.togglePushNotifications,
                                    ),
                                    const Divider(color: AppColors.borderLight, height: 20),
                                    SettingsToggleTile(
                                      title: 'SMS Emergency Weather Alerts',
                                      subtitle: 'Receive SMS texts for urgent school closure notices',
                                      value: settingsProvider.settings.smsWeatherAlerts,
                                      onChanged: settingsProvider.toggleSmsWeatherAlerts,
                                    ),
                                    const Divider(color: AppColors.borderLight, height: 20),
                                    SettingsToggleTile(
                                      title: 'Daily Homework Digest Email',
                                      subtitle: 'Receive a daily 06:00 PM email summary of all assigned homework',
                                      value: settingsProvider.settings.dailyDigestEmail,
                                      onChanged: settingsProvider.toggleDailyDigestEmail,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],

                              // SECTION 2: Privacy & Security
                              if (activeTab == 'all' || activeTab == 'security') ...[
                                const _SectionCard(
                                  iconEmoji: '🛡️',
                                  title: 'Privacy & Account Security',
                                  subtitle:
                                      'Notice Board India strictly protects user privacy — We do not collect or track your personal data',
                                  children: [
                                    _PrivacyRow(
                                      title: 'Zero Data Collection Policy',
                                      subtitle:
                                          'We do not collect, harvest, or store your personal browsing history, location, or private device contacts.',
                                      badgeText: '🔒 100% Private',
                                      isGreen: true,
                                    ),
                                    Divider(color: AppColors.borderLight, height: 20),
                                    _PrivacyRow(
                                      title: 'School Content Display Only',
                                      subtitle:
                                          'This platform is built exclusively to publish and view official school announcements, circulars, and feed updates.',
                                      badgeText: '📢 Content Only',
                                      isGreen: false,
                                    ),
                                    Divider(color: AppColors.borderLight, height: 20),
                                    _PrivacyRow(
                                      title: 'Local Device Storage',
                                      subtitle:
                                          'Your profile preferences and followed school selections are stored safely and locally on your own device.',
                                      badgeText: '📱 Saved Locally',
                                      isGreen: true,
                                    ),
                                    Divider(color: AppColors.borderLight, height: 20),
                                    _PrivacyRow(
                                      title: 'No Third-Party Tracking',
                                      subtitle:
                                          'No ad trackers, behavioral profiling, or invasive analytics cookies are used on Notice Board India.',
                                      badgeText: '🛡️ Verified Safe',
                                      isGreen: false,
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Right Sidebar on Desktop
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
              if (settingsProvider.toastMessage != null)
                ToastNotification(
                  message: settingsProvider.toastMessage!,
                  onDismiss: settingsProvider.clearToast,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: !isTabletOrDesktop
          ? const MobileBottomNavBar(activeRoute: AppRoutes.settings)
          : null,
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryOrange : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primaryOrange : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF5A00).withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: AppTypography.caption(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String iconEmoji;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SectionCard({
    required this.iconEmoji,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(iconEmoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.heading3(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.caption(
                        fontSize: 12,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}

class _PrivacyRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final bool isGreen;

  const _PrivacyRow({
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.isGreen,
  });

  @override
  Widget build(BuildContext context) {
    final color = isGreen ? AppColors.activeGreen : AppColors.roleBlueText;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyBold(fontSize: 14)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTypography.caption(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            badgeText,
            style: AppTypography.caption(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
