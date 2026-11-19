import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/sidebar_navigation.dart';
import '../../../core/widgets/toast_notification.dart';
import '../../auth/providers/auth_provider.dart';
import '../../feed/widgets/community_widget.dart';
import '../../feed/widgets/sponsored_store_widget.dart';
import '../providers/profile_provider.dart';
import '../widgets/edit_profile_dialog.dart';

/// Profile Screen - Production architecture using Provider.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTabletOrDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.bgSurface,
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Navigation Sidebar
                  if (isTabletOrDesktop)
                    const SidebarNavigation(activeRoute: AppRoutes.profile),

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
                              // Hero Profile Card
                              _ProfileHeroCard(
                                profileProvider: profileProvider,
                              ),
                              const SizedBox(height: 24),

                              // Section 1: User Details
                              _UserDetailsSection(
                                profileProvider: profileProvider,
                              ),
                              const SizedBox(height: 24),

                              // Section 2: Following Schools, Class & Division
                              const _FollowingSchoolsSection(),
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
              if (profileProvider.toastMessage != null)
                ToastNotification(
                  message: profileProvider.toastMessage!,
                  onDismiss: profileProvider.clearToast,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: !isTabletOrDesktop
          ? const MobileBottomNavBar(activeRoute: AppRoutes.profile)
          : null,
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  final ProfileProvider profileProvider;

  const _ProfileHeroCard({required this.profileProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Banner Frame
          Container(
            height: 130,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFF7A29), Color(0xFFFF5A00)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  width: 200,
                  child: Opacity(
                    opacity: 0.25,
                    child: Transform.flip(
                      flipX: true,
                      child: Image.asset(AppAssets.splash1),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar + Action Buttons Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Circular Avatar
                    Transform.translate(
                      offset: const Offset(0, -36),
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          AppAssets.teacherAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Actions: Edit Profile & Log Out
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              profileProvider.openEditModal();
                              showDialog(
                                context: context,
                                builder: (_) => const EditProfileDialog(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFCBD5E1),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit_outlined,
                                    size: 16,
                                    color: Color(0xFF334155),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Edit Profile',
                                    style: AppTypography.caption(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF334155),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              final authProvider = context.read<AuthProvider>();
                              authProvider.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.signup,
                                (route) => false,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEEEC),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFFECDD3),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    size: 16,
                                    color: Color(0xFFEF4444),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Log Out',
                                    style: AppTypography.caption(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFEF4444),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Name & Verified Badge
                Row(
                  children: [
                    Text(
                      profileProvider.fullName,
                      style: AppTypography.heading1(fontSize: 22),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.verified,
                      color: Color(0xFF0095F6),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Role Dropdown & Verified Pill
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Role Dropdown UI
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: profileProvider.role,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: AppColors.textMuted,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Student',
                              child: Text('🎓 Student'),
                            ),
                            DropdownMenuItem(
                              value: 'Parent',
                              child: Text('👨‍👩‍👧 Parent'),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) profileProvider.setRole(val);
                          },
                        ),
                      ),
                    ),

                    // Verified status pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.activeGreen.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.activeGreen,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Verified Account',
                            style: AppTypography.caption(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.activeGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserDetailsSection extends StatelessWidget {
  final ProfileProvider profileProvider;

  const _UserDetailsSection({required this.profileProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('👤', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Details',
                    style: AppTypography.heading3(fontSize: 16),
                  ),
                  Text(
                    'Basic user identity & contact info',
                    style: AppTypography.caption(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),

          _FieldItem(label: 'Full Name', value: profileProvider.fullName),
          const Divider(color: AppColors.borderLight, height: 20),
          _FieldItem(label: 'Registered Email', value: profileProvider.email),
          const Divider(color: AppColors.borderLight, height: 20),
          _FieldItem(
            label: 'Contact Number',
            value: '+91 ${profileProvider.phone}',
          ),
        ],
      ),
    );
  }
}

class _FieldItem extends StatelessWidget {
  final String label;
  final String value;

  const _FieldItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.caption(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
        ),
        Text(value, style: AppTypography.bodyBold(fontSize: 13)),
      ],
    );
  }
}

class _FollowingSchoolsSection extends StatelessWidget {
  const _FollowingSchoolsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🏫', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Following Schools, Class & Division',
                    style: AppTypography.heading3(fontSize: 16),
                  ),
                  Text(
                    'Subscribed educational institutions and selected class views',
                    style: AppTypography.caption(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),

          // School 1
          _SchoolItem(
            name: "St. Mary's Higher Secondary School",
            logo: AppAssets.crestSalford,
            className: 'Class 10',
            division: 'Division A',
          ),
          const SizedBox(height: 14),

          // School 2
          _SchoolItem(
            name: 'Carmel Girls Higher Secondary School',
            logo: AppAssets.crestCarmel,
            className: 'Class 8',
            division: 'Division B',
          ),
        ],
      ),
    );
  }
}

class _SchoolItem extends StatelessWidget {
  final String name;
  final String logo;
  final String className;
  final String division;

  const _SchoolItem({
    required this.name,
    required this.logo,
    required this.className,
    required this.division,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderLight),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(logo, fit: BoxFit.contain),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTypography.heading3(fontSize: 14)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      children: [
                        _Tag(text: className),
                        _Tag(text: division),
                        const _Tag(text: '🟢 Active Feed', isGreen: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.selectInstitution),
                child: const Text(
                  'Change School',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.selectClassDivision),
                child: const Text(
                  'Change Class/Div',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool isGreen;

  const _Tag({required this.text, this.isGreen = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isGreen
            ? AppColors.activeGreen.withValues(alpha: 0.12)
            : AppColors.bgWhite,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isGreen
              ? AppColors.activeGreen.withValues(alpha: 0.3)
              : AppColors.borderMedium,
        ),
      ),
      child: Text(
        text,
        style: AppTypography.caption(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isGreen ? AppColors.activeGreen : AppColors.textBody,
        ),
      ),
    );
  }
}
