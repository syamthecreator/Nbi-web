import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/workspace_provider.dart';

/// Opens system file picker / gallery on click and displays uploaded logo preview.
class SchoolLogoDropzone extends StatelessWidget {
  final WorkspaceProvider wsProvider;

  const SchoolLogoDropzone({super.key, required this.wsProvider});

  @override
  Widget build(BuildContext context) {
    final hasLogo =
        wsProvider.schoolLogoBytes != null ||
        wsProvider.schoolLogoAsset != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'School Logo (Optional)',
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (!hasLogo) {
              wsProvider.pickSchoolLogo();
            }
          },
          child: CustomPaint(
            foregroundPainter: DashedBorderPainter(
              color: const Color(0xFFFCA5A5),
              radius: 16,
              strokeWidth: 1.5,
              dashLength: 6,
              dashGap: 4,
            ),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 124),
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: !hasLogo
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFEAE0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.primaryOrange,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Click to Upload Logo',
                          style: GoogleFonts.montserrat(
                            fontSize: 13.6,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'PNG, JPG or SVG • Optional',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Circular preview matching .uploaded-logo-preview
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.primaryOrange,
                              width: 2.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x29FF5A00),
                                blurRadius: 14,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: wsProvider.schoolLogoBytes != null
                              ? Image.memory(
                                  wsProvider.schoolLogoBytes!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  wsProvider.schoolLogoAsset!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Uploaded School Logo',
                              style: GoogleFonts.inter(
                                fontSize: 13.8,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            if (wsProvider.schoolLogoFileName != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                wsProvider.schoolLogoFileName!,
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: wsProvider.removeSchoolLogo,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEEEC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFFECDD3),
                                  ),
                                ),
                                child: Text(
                                  '× Remove Logo',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFEF4444),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
        ),
      ],
    );
  }
}

/// Custom painter for pixel-perfect dashed border on rounded rectangles
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final double radius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashLength = 6.0,
    this.dashGap = 4.0,
    this.radius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rrect);
    final dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashLength : dashGap;
        if (distance + length > metric.length) {
          if (draw) {
            dashedPath.addPath(
              metric.extractPath(distance, metric.length),
              Offset.zero,
            );
          }
          break;
        }
        if (draw) {
          dashedPath.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashGap != dashGap;
  }
}
