import 'package:flutter/material.dart';
import '../../app/routes/app_routes.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class SidebarNavigation extends StatelessWidget {
  final String activeRoute;

  const SidebarNavigation({
    super.key,
    required this.activeRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xFFEAEAEA), width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Branding
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Notice Board ',
                              style: AppTypography.heading3(
                                fontSize: 16,
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'India',
                              style: AppTypography.heading3(
                                fontSize: 16,
                                color: const Color(0xFF111111),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Stay Informed. Stay connected.',
                        style: AppTypography.caption(
                          fontSize: 10,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Menu Items
          _SidebarItem(
            icon: Icons.newspaper_outlined,
            title: 'School Feed',
            isActive: activeRoute == AppRoutes.schoolFeed,
            onTap: () {
              if (activeRoute != AppRoutes.schoolFeed) {
                Navigator.pushReplacementNamed(context, AppRoutes.schoolFeed);
              }
            },
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            isActive: activeRoute == AppRoutes.settings,
            onTap: () {
              if (activeRoute != AppRoutes.settings) {
                Navigator.pushReplacementNamed(context, AppRoutes.settings);
              }
            },
          ),
          _SidebarItem(
            icon: Icons.person_outline,
            title: 'Profile',
            isActive: activeRoute == AppRoutes.profile,
            onTap: () {
              if (activeRoute != AppRoutes.profile) {
                Navigator.pushReplacementNamed(context, AppRoutes.profile);
              }
            },
          ),

          const Spacer(),

          // Bottom Logout / Exit
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.selectRole, (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 18, color: Color(0xFFDC2626)),
                    const SizedBox(width: 10),
                    Text(
                      'Logout / Switch Role',
                      style: AppTypography.caption(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFFF0E6) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isActive
                ? Border.all(color: const Color(0xFFFF8C42).withValues(alpha: 0.3))
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.primaryOrange : const Color(0xFF64748B),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTypography.bodyMedium(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? AppColors.primaryOrange : const Color(0xFF334155),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileBottomNavBar extends StatelessWidget {
  final String activeRoute;

  const MobileBottomNavBar({
    super.key,
    required this.activeRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEAEAEA), width: 1.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.newspaper_outlined,
            label: 'Feed',
            isActive: activeRoute == AppRoutes.schoolFeed,
            onTap: () {
              if (activeRoute != AppRoutes.schoolFeed) {
                Navigator.pushReplacementNamed(context, AppRoutes.schoolFeed);
              }
            },
          ),
          _BottomNavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            isActive: activeRoute == AppRoutes.settings,
            onTap: () {
              if (activeRoute != AppRoutes.settings) {
                Navigator.pushReplacementNamed(context, AppRoutes.settings);
              }
            },
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: activeRoute == AppRoutes.profile,
            onTap: () {
              if (activeRoute != AppRoutes.profile) {
                Navigator.pushReplacementNamed(context, AppRoutes.profile);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? AppColors.primaryOrange : const Color(0xFF64748B),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primaryOrange : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
