import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/settings_provider.dart';
import 'settings_toggle_tile.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        final activeTab = settingsProvider.activeTab;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    color: Color(0x08000000),
                    blurRadius: 18,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings & Preferences',
                    style: GoogleFonts.montserrat(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category Tabs
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _SettingsTabButton(
                        title: 'All Settings',
                        isActive: activeTab == 'all',
                        onTap: () => settingsProvider.setActiveTab('all'),
                      ),
                      _SettingsTabButton(
                        title: 'Notification Preferences',
                        isActive: activeTab == 'notifications',
                        onTap: () =>
                            settingsProvider.setActiveTab('notifications'),
                      ),
                      _SettingsTabButton(
                        title: 'Privacy & Security',
                        isActive: activeTab == 'security',
                        onTap: () => settingsProvider.setActiveTab('security'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SCROLLABLE content only
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SECTION 1: Notification Preferences
                    if (activeTab == 'all' || activeTab == 'notifications') ...[
                      _SettingsSectionCard(
                        iconEmoji: '🔔',
                        iconBg: const Color(0xFFFFF8E7),
                        title: 'Notification Alerts & Channels',
                        subtitle: 'Choose how and when you want to receive school notifications',
                        children: [
                          SettingsToggleTile(
                            title: 'Push Notifications',
                            subtitle: 'Receive real-time push alerts for school announcements',
                            value: settingsProvider.settings.pushNotifications,
                            onChanged: settingsProvider.togglePushNotifications,
                          ),
                          const Divider(color: Color(0xFFFAFAFA), height: 32),
                          SettingsToggleTile(
                            title: 'SMS Emergency Weather Alerts',
                            subtitle: 'Receive SMS texts for urgent school closure notices',
                            value: settingsProvider.settings.smsWeatherAlerts,
                            onChanged: settingsProvider.toggleSmsWeatherAlerts,
                          ),
                          const Divider(color: Color(0xFFFAFAFA), height: 32),
                          SettingsToggleTile(
                            title: 'Daily Homework Digest Email',
                            subtitle: 'Receive a daily 06:00 PM email summary of all assigned homework',
                            value: settingsProvider.settings.dailyDigestEmail,
                            onChanged: settingsProvider.toggleDailyDigestEmail,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],

                    // SECTION 2: Privacy & Security
                    if (activeTab == 'all' || activeTab == 'security') ...[
                      const _SettingsSectionCard(
                        iconEmoji: '🛡️',
                        iconBg: Color(0xFFEFF6FF),
                        title: 'Privacy & Account Security',
                        subtitle: 'Notice Board India strictly protects user privacy — We do not collect or track your personal data',
                        children: [
                          _PrivacyRow(
                            title: 'Zero Data Collection Policy',
                            subtitle: 'We do not collect, harvest, or store your personal browsing history, location, or private device contacts.',
                            badgeText: '🔒 100% Private',
                            isGreen: true,
                          ),
                          Divider(color: Color(0xFFFAFAFA), height: 32),
                          _PrivacyRow(
                            title: 'School Content Display Only',
                            subtitle: 'This platform is built exclusively to publish and view official school announcements, circulars, and feed updates.',
                            badgeText: '📢 Content Only',
                            isGreen: false,
                          ),
                          Divider(color: Color(0xFFFAFAFA), height: 32),
                          _PrivacyRow(
                            title: 'Local Device Storage',
                            subtitle: 'Your profile preferences and followed school selections are stored safely and locally on your own device.',
                            badgeText: '📱 Saved Locally',
                            isGreen: true,
                          ),
                          Divider(color: Color(0xFFFAFAFA), height: 32),
                          _PrivacyRow(
                            title: 'No Third-Party Tracking',
                            subtitle: 'No ad trackers, behavioral profiling, or invasive analytics cookies are used on Notice Board India.',
                            badgeText: '🛡️ Verified Safe',
                            isGreen: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsTabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _SettingsTabButton({
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryOrange : const Color(0xFFF2F3F5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: Color(0x40FF5A00),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 13.6,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF555555),
          ),
        ),
      ),
    );
  }
}

class _SettingsSectionCard extends StatelessWidget {
  final String iconEmoji;
  final Color iconBg;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SettingsSectionCard({
    required this.iconEmoji,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0A000000), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(iconEmoji, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 17.6,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF3F4F6), height: 1),
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
    final bgColor = isGreen ? const Color(0xFFECFDF5) : const Color(0xFFEFF6FF);
    final textColor = isGreen
        ? const Color(0xFF059669)
        : const Color(0xFF2563EB);
    final borderColor = isGreen
        ? const Color(0xFFA7F3D0)
        : const Color(0xFFBFDBFE);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.7,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 3),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Text(
            badgeText,
            style: GoogleFonts.montserrat(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
