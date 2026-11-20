import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/routes/app_routes.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class SidebarNavigation extends StatelessWidget {
  final String activeRoute;
  final double width;
  final ValueChanged<String>? onRouteSelected;

  const SidebarNavigation({
    super.key,
    required this.activeRoute,
    this.width = 280,
    this.onRouteSelected,
  });

  void _handleNavigation(BuildContext context, String route) {
    if (activeRoute == route) return;
    if (onRouteSelected != null) {
      onRouteSelected!(route);
    } else {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Branding Header
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
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
                              fontSize: 16.5,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'India',
                            style: AppTypography.heading3(
                              fontSize: 16.5,
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
                        fontSize: 11.5,
                        color: const Color(0xFF777777),
                      ).copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 18),

          // Navigation Links
          _SidebarItem(
            icon: Icons.description_outlined,
            title: 'School Feed',
            isActive: activeRoute == AppRoutes.schoolFeed,
            onTap: () => _handleNavigation(context, AppRoutes.schoolFeed),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            isActive: activeRoute == AppRoutes.settings,
            onTap: () => _handleNavigation(context, AppRoutes.settings),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.person_outline,
            title: 'Profile',
            isActive: activeRoute == AppRoutes.profile,
            onTap: () => _handleNavigation(context, AppRoutes.profile),
          ),

          const Spacer(),

          // Bottom Illustration & Copyright
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 210),
                  child: Image.asset(
                    activeRoute == AppRoutes.schoolFeed
                        ? AppAssets.splashKids
                        : AppAssets.buildingSketch,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '© 2024 Notice Board India\nAll rights reserved.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    color: const Color(0xFF888888),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
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
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isActive;
    final Color itemColor = active || _isHovered
        ? AppColors.primaryOrange
        : const Color(0xFF444444);
    final Color iconColor = active || _isHovered
        ? AppColors.primaryOrange
        : const Color(0xFF666666);
    final Color bgColor = active
        ? const Color(0xFFFFF0E6)
        : (_isHovered ? const Color(0xFFF9FAFB) : Colors.transparent);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (active)
                Positioned(
                  left: 0,
                  top: 8,
                  bottom: 8,
                  width: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 20,
                      color: iconColor,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      widget.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                        color: itemColor,
                      ),
                    ),
                  ],
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
  final ValueChanged<String>? onRouteSelected;

  const MobileBottomNavBar({
    super.key,
    required this.activeRoute,
    this.onRouteSelected,
  });

  void _handleNavigation(BuildContext context, String route) {
    if (activeRoute == route) return;
    if (onRouteSelected != null) {
      onRouteSelected!(route);
    } else {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: 'Feed',
            isActive: activeRoute == AppRoutes.schoolFeed,
            onTap: () => _handleNavigation(context, AppRoutes.schoolFeed),
          ),
          _BottomNavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            isActive: activeRoute == AppRoutes.settings,
            onTap: () => _handleNavigation(context, AppRoutes.settings),
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: activeRoute == AppRoutes.profile,
            onTap: () => _handleNavigation(context, AppRoutes.profile),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.primaryOrange : const Color(0xFF6B7280),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? AppColors.primaryOrange : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
