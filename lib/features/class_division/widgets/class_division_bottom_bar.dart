import 'package:flutter/material.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/custom_button.dart';

/// Sticky bottom action bar for Class & Division screen.
class ClassDivisionBottomBar extends StatelessWidget {
  const ClassDivisionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: Color(0xFFEAEAEA), width: 1.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Class & division configured',
                style: AppTypography.bodyBold(
                  fontSize: 15,
                  color: AppColors.primaryOrange,
                ),
              ),
              CustomButton(
                text: 'Next',
                width: 200,
                height: 50,
                borderRadius: BorderRadius.circular(25),
                trailingIcon: const Icon(Icons.arrow_forward_rounded, size: 16),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.schoolFeed);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
