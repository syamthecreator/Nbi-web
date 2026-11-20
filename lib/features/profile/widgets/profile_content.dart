import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_dialog.dart';
import 'role_dropdown_button.dart';

/// Profile Content View matching source_nbi (.profile-container)
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
              // Hero Profile Card (.profile-hero-card)
              _ProfileHeroCard(profileProvider: profileProvider),
              const SizedBox(height: 20),

              // Section 1: User Details (.profile-section-card)
              _UserDetailsSection(profileProvider: profileProvider),
              const SizedBox(height: 20),

              // Section 2: Following Schools, Class & Division (.profile-section-card)
              const _FollowingSchoolsSection(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

/// Profile Hero Card matching source_nbi (.profile-hero-card)
class _ProfileHeroCard extends StatefulWidget {
  final ProfileProvider profileProvider;

  const _ProfileHeroCard({required this.profileProvider});

  @override
  State<_ProfileHeroCard> createState() => _ProfileHeroCardState();
}

class _ProfileHeroCardState extends State<_ProfileHeroCard> {
  bool _isEditHovered = false;
  bool _isLogoutHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0A000000)), // rgba(0,0,0,0.04)
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000), // rgba(0,0,0,0.03)
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Frame (.profile-cover-banner: linear-gradient(135deg, #FF6000 0%, #FF4500 60%, #1E293B 100%))
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.6, 1.0],
                colors: [
                  Color(0xFFFF6000),
                  Color(0xFFFF4500),
                  Color(0xFF1E293B),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),

          // Avatar & Action Buttons Row (.profile-avatar-wrapper)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Avatar (.profile-avatar-frame: 96x96 with 4px border overlapping banner)
                Transform.translate(
                  offset: const Offset(0, -45),
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000), // rgba(0,0,0,0.12)
                          blurRadius: 18,
                          offset: Offset(0, 6),
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

                // Actions: Edit Profile & Log Out (.profile-hero-actions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      // Edit Profile Button (.btn-profile-edit)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => _isEditHovered = true),
                        onExit: (_) => setState(() => _isEditHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            widget.profileProvider.openEditModal();
                            showDialog(
                              context: context,
                              barrierColor: const Color(0x8C0F172A), // rgba(15, 23, 42, 0.55)
                              barrierDismissible: true,
                              builder: (_) => const EditProfileDialog(),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: _isEditHovered
                                ? Matrix4.translationValues(0, -2, 0)
                                : Matrix4.identity(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 9.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _isEditHovered
                                    ? const [Color(0xFFE04E00), Color(0xFFC74400)]
                                    : const [Color(0xFFFF5A00), Color(0xFFE04E00)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40FF5A00),
                                  blurRadius: _isEditHovered ? 18 : 14,
                                  offset: Offset(0, _isEditHovered ? 6 : 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Edit Profile',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Log Out Button (.btn-profile-logout)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => _isLogoutHovered = true),
                        onExit: (_) => setState(() => _isLogoutHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            final authProvider = context.read<AuthProvider>();
                            authProvider.logout();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.signup,
                              (route) => false,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: _isLogoutHovered
                                ? Matrix4.translationValues(0, -2, 0)
                                : Matrix4.identity(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: _isLogoutHovered
                                    ? const [Color(0xFFEF4444), Color(0xFFDC2626)]
                                    : const [Color(0xFFFEF2F2), Color(0xFFFFE4E6)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _isLogoutHovered
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFFFCA5A5),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x14DC2626),
                                  blurRadius: _isLogoutHovered ? 18 : 8,
                                  offset: Offset(0, _isLogoutHovered ? 6 : 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  size: 17,
                                  color: _isLogoutHovered
                                      ? Colors.white
                                      : const Color(0xFFDC2626),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Log Out',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _isLogoutHovered
                                        ? Colors.white
                                        : const Color(0xFFDC2626),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // User Info & Pills (.profile-meta-info)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Verified Badge (.profile-user-name)
                Row(
                  children: [
                    Text(
                      widget.profileProvider.fullName,
                      style: GoogleFonts.montserrat(
                        fontSize: 22.4,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Verified Badge Icon (.verified-badge-icon)
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x4D0095F6),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Color(0xFF0095F6),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Role Dropdown & Verified Pill (.profile-subtext)
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Role Dropdown Button (Select2 Style matching source_nbi)
                    RoleDropdownButton(
                      selectedRole: widget.profileProvider.role,
                      onRoleSelected: (newRole) {
                        widget.profileProvider.setRole(newRole);
                      },
                    ),

                    // Verified Account Status Pill Tag (.verified-status-pill)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFA7F3D0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Verified Account',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF047857),
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

/// Section 1: User Details Card matching source_nbi (.profile-section-card)
class _UserDetailsSection extends StatelessWidget {
  final ProfileProvider profileProvider;

  const _UserDetailsSection({required this.profileProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0A000000)),
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
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text('👤', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Details',
                      style: GoogleFonts.montserrat(
                        fontSize: 17.6,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Basic user identity & contact info',
                      style: GoogleFonts.inter(
                        fontSize: 12,
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
          const SizedBox(height: 20),

          // 3-Column Info Fields Grid matching source_nbi (.info-fields-grid)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              if (isNarrow) {
                return Column(
                  children: [
                    _InfoFieldBox(
                      label: 'Full Name',
                      value: profileProvider.fullName,
                    ),
                    const SizedBox(height: 12),
                    _InfoFieldBox(
                      label: 'Registered Email',
                      value: profileProvider.email,
                    ),
                    const SizedBox(height: 12),
                    _InfoFieldBox(
                      label: 'Contact Number',
                      value: '+91 ${profileProvider.phone}',
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _InfoFieldBox(
                      label: 'Full Name',
                      value: profileProvider.fullName,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _InfoFieldBox(
                      label: 'Registered Email',
                      value: profileProvider.email,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _InfoFieldBox(
                      label: 'Contact Number',
                      value: '+91 ${profileProvider.phone}',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Info Field Item matching source_nbi (.info-field-item)
class _InfoFieldBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoFieldBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section 2: Following Schools, Class & Division matching source_nbi (.profile-section-card)
class _FollowingSchoolsSection extends StatelessWidget {
  const _FollowingSchoolsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0A000000)),
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
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text('🏫', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Following Schools, Class & Division',
                      style: GoogleFonts.montserrat(
                        fontSize: 17.6,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Subscribed educational institutions and selected class views',
                      style: GoogleFonts.inter(
                        fontSize: 12,
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

          // School 1 Card Item (.following-school-card)
          const _FollowingSchoolCard(
            name: "Kendriya Vidyalaya Pangode",
            logo: AppAssets.crestSalford,
            className: 'Class 10',
            division: 'Division A',
          ),
          const SizedBox(height: 14),

          // School 2 Card Item (.following-school-card)
          const _FollowingSchoolCard(
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

/// Single Followed School Card Item matching source_nbi (.following-school-card)
class _FollowingSchoolCard extends StatefulWidget {
  final String name;
  final String logo;
  final String className;
  final String division;

  const _FollowingSchoolCard({
    required this.name,
    required this.logo,
    required this.className,
    required this.division,
  });

  @override
  State<_FollowingSchoolCard> createState() => _FollowingSchoolCardState();
}

class _FollowingSchoolCardState extends State<_FollowingSchoolCard> {
  bool _isCardHovered = false;
  bool _isChangeSchoolHovered = false;
  bool _isChangeClassHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isCardHovered = true),
      onExit: (_) => setState(() => _isCardHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isCardHovered
            ? Matrix4.translationValues(0, -2, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: _isCardHovered
              ? const [
                  BoxShadow(
                    color: Color(0x0A000000), // rgba(0, 0, 0, 0.04)
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 560;

            final schoolDetails = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(widget.logo, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.className,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1D4ED8),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.division,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ),
                          Text(
                            '🟢 Active Feed',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF15803D),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );

            final actionButtons = Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                // Change School Button (.btn-manage-school)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _isChangeSchoolHovered = true),
                  onExit: (_) => setState(() => _isChangeSchoolHovered = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.selectInstitution);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _isChangeSchoolHovered
                            ? const Color(0xFFF3F4F6)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isChangeSchoolHovered
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFFD1D5DB),
                        ),
                      ),
                      child: Text(
                        'Change School',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _isChangeSchoolHovered
                              ? const Color(0xFF111111)
                              : const Color(0xFF374151),
                        ),
                      ),
                    ),
                  ),
                ),

                // Change Class/Div Button (.btn-manage-class)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _isChangeClassHovered = true),
                  onExit: (_) => setState(() => _isChangeClassHovered = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.selectClassDivision);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _isChangeClassHovered
                            ? const Color(0xFFE04E00)
                            : AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isChangeClassHovered
                              ? const Color(0xFFE04E00)
                              : AppColors.primaryOrange,
                        ),
                      ),
                      child: Text(
                        'Change Class/Div',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  schoolDetails,
                  const SizedBox(height: 14),
                  actionButtons,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: schoolDetails),
                const SizedBox(width: 16),
                actionButtons,
              ],
            );
          },
        ),
      ),
    );
  }
}
