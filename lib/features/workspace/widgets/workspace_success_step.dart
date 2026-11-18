import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/workspace_provider.dart';

/// Step 3: Workspace creation success & summary card matching create-workspace.html & create-workspace.css #step3Block
class WorkspaceSuccessStep extends StatelessWidget {
  final WorkspaceProvider wsProvider;
  final bool isDesktop;

  const WorkspaceSuccessStep({
    super.key,
    required this.wsProvider,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final ws = wsProvider.createdWorkspace;

    // Check auto-redirect
    if (wsProvider.redirectCountdown == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.schoolFeed);
      });
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 20,
            vertical: isDesktop ? 36 : 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFFFE4D6), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14FF5A00),
                blurRadius: 48,
                offset: Offset(0, 14),
              ),
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Celebration Badge with checkmark and sparkle emojis (.success-icon-badge)
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x5910B981),
                          blurRadius: 28,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.check_rounded, color: Colors.white, size: 48),
                    ),
                  ),
                  const Positioned(top: -10, left: -12, child: Text('✨', style: TextStyle(fontSize: 22))),
                  const Positioned(top: -14, right: -10, child: Text('🎉', style: TextStyle(fontSize: 22))),
                  const Positioned(bottom: -6, right: 6, child: Text('⭐', style: TextStyle(fontSize: 20))),
                ],
              ),
              const SizedBox(height: 20),

              // Title (.workspace-success-title)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Workspace ',
                      style: GoogleFonts.montserrat(
                        fontSize: isDesktop ? 32 : 26,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'Created!',
                      style: GoogleFonts.montserrat(
                        fontSize: isDesktop ? 32 : 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryOrange,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle (.workspace-success-subtitle)
              Text(
                'Congratulations! Your secure institution workspace is live and ready to connect.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // Inner Summary Card (.workspace-success-card)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9F5), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFDCD0), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0DFF5A00),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header: Logo + Name + Badge
                    Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFEAE0),
                            border: Border.all(color: AppColors.primaryOrange, width: 2.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33FF5A00),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ws?.schoolLogoUrl != null
                              ? Image.asset(ws!.schoolLogoUrl!, fit: BoxFit.cover)
                              : const Center(child: Text('🏫', style: TextStyle(fontSize: 26))),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ws?.institutionName.isNotEmpty == true
                                    ? ws!.institutionName
                                    : 'Oxford High School',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEAE0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  ws?.institutionType.isNotEmpty == true
                                      ? ws!.institutionType
                                      : 'Higher Secondary School',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFD94800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: Color(0xFFFFE4D6), height: 1),
                    const SizedBox(height: 18),

                    // 4-Cell Details Grid (.success-details-grid)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _DetailBox(
                                label: 'WORKSPACE URL',
                                value: 'nbi.in/${ws?.workspaceName.isNotEmpty == true ? ws!.workspaceName : 'oxford-hs'}',
                                isOrange: true,
                              ),
                              const SizedBox(height: 14),
                              _DetailBox(
                                label: 'PRIMARY ADMIN',
                                value: ws?.adminFullName.isNotEmpty == true
                                    ? ws!.adminFullName
                                    : 'Rahul Sharma',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              _DetailBox(
                                label: 'INSTITUTION CODE',
                                value: ws?.institutionCode.isNotEmpty == true
                                    ? ws!.institutionCode
                                    : 'NBI-SCH-8842',
                              ),
                              const SizedBox(height: 14),
                              _DetailBox(
                                label: 'DESIGNATION',
                                value: ws?.adminDesignation.isNotEmpty == true
                                    ? ws!.adminDesignation
                                    : 'Principal / Headmaster',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Status Badge Row (.badge-status-active)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFBBF7D0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF16A34A),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x9916A34A),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Workspace Status: Active & Verified',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF15803D),
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
              const SizedBox(height: 28),

              // Action Button (.btn-workspace-success-action)
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 360),
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x59FF5A00),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      wsProvider.cancelRedirectTimer();
                      Navigator.pushReplacementNamed(context, AppRoutes.schoolFeed);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Go to Institution Feed',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Redirect Timer Row (.redirect-info-row & .redirect-progress-track)
              Column(
                children: [
                  Text(
                    'Redirecting to Feed in ${wsProvider.redirectCountdown}s...',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 240,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: ((5 - wsProvider.redirectCountdown) / 5.0).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isOrange;

  const _DetailBox({
    required this.label,
    required this.value,
    this.isOrange = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: isOrange ? AppColors.primaryOrange : const Color(0xFF1E293B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
