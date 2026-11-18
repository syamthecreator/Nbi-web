import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/background_shapes.dart';
import '../../../core/widgets/toast_notification.dart';
import '../providers/workspace_provider.dart';
import '../widgets/workspace_header.dart';
import '../widgets/workspace_step1_form.dart';
import '../widgets/workspace_step2_form.dart';
import '../widgets/workspace_success_step.dart';

/// Create Workspace Screen - Clean production architecture using Provider.
/// Pure Stateless architecture with Provider. Zero setState().
/// 1:1 match with source_nbi/pages/create-workspace.html and create-workspace.css.
class CreateWorkspaceScreen extends StatelessWidget {
  const CreateWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Stack(
        children: [
          // Background Shape: Top Right
          const BackgroundShapes(showTopRight: true),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 48 : 20,
                vertical: isDesktop ? 40 : 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Consumer<WorkspaceProvider>(
                    builder: (context, wsProvider, _) {
                      final step = wsProvider.currentStep;

                      if (step == WorkspaceStep.success) {
                        return WorkspaceSuccessStep(wsProvider: wsProvider, isDesktop: isDesktop);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Header & Hero Row
                          WorkspaceHeader(isDesktop: isDesktop),
                          const SizedBox(height: 24),

                          // Step Progress Indicator Bar
                          _WorkspaceProgressBar(step: step),
                          const SizedBox(height: 36),

                          // Form Content sits DIRECTLY on page background (no outer container card)
                          if (step == WorkspaceStep.institutionDetails)
                            WorkspaceStep1Form(wsProvider: wsProvider, isDesktop: isDesktop)
                          else if (step == WorkspaceStep.adminDetails)
                            WorkspaceStep2Form(wsProvider: wsProvider, isDesktop: isDesktop),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Global Toast Notification matching create-workspace.css .toast-alert
          Consumer<WorkspaceProvider>(
            builder: (context, wsProvider, _) {
              if (wsProvider.toastMessage != null) {
                return ToastNotification(
                  message: wsProvider.toastMessage!,
                  onDismiss: wsProvider.clearToast,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _WorkspaceProgressBar extends StatelessWidget {
  final WorkspaceStep step;

  const _WorkspaceProgressBar({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step == WorkspaceStep.institutionDetails ? 'Step 1/2' : 'Step 2/2',
          style: AppTypography.caption(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: step == WorkspaceStep.institutionDetails ? 0.5 : 1.0,
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
    );
  }
}
