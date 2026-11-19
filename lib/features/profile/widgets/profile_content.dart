import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_dialog.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Profile Card
              _ProfileHeroCard(profileProvider: profileProvider),
              const SizedBox(height: 20),

              // Section 1: User Details
              _UserDetailsSection(profileProvider: profileProvider),
              const SizedBox(height: 20),

              // Section 2: Following Schools, Class & Division
              const _FollowingSchoolsSection(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 18,
            offset: Offset(0, 4),
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
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 24),
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
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F000000),
                              blurRadius: 14,
                              offset: Offset(0, 4),
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
                      style: AppTypography.heading1(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
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
                        color: const Color(0xFFF3F4F6),
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
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
              const Text('👤', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Details',
                    style: AppTypography.heading3(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Basic user identity & contact info',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFF3F4F6), height: 1),
          const SizedBox(height: 16),

          _FieldItem(label: 'Full Name', value: profileProvider.fullName),
          const Divider(color: Color(0xFFF3F4F6), height: 20),
          _FieldItem(label: 'Registered Email', value: profileProvider.email),
          const Divider(color: Color(0xFFF3F4F6), height: 20),
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
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF6B7280),
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyBold(fontSize: 13),
        ),
      ],
    );
  }
}

class _FollowingSchoolsSection extends StatelessWidget {
  const _FollowingSchoolsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
              const Text('🏫', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Following Schools, Class & Division',
                      style: AppTypography.heading3(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Subscribed educational institutions and selected class views',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFF3F4F6), height: 1),
          const SizedBox(height: 16),

          // School 1
          const _SchoolItem(
            name: "St. Mary's Higher Secondary School",
            logo: AppAssets.crestSalford,
            className: 'Class 10',
            division: 'Division A',
          ),
          const SizedBox(height: 14),

          // School 2
          const _SchoolItem(
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
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(logo, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        className,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        division,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFD97706),
                        ),
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
