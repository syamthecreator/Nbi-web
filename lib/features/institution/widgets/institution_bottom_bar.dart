import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../class_division/providers/class_division_provider.dart';
import '../providers/institution_provider.dart';

/// Sticky bottom action bar matching source_nbi .bottom-action-bar.
class InstitutionBottomBar extends StatelessWidget {
  final InstitutionProvider instProvider;

  const InstitutionBottomBar({super.key, required this.instProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: Color(0xFFEAEAEA), width: 1.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${instProvider.selectedCount} institution${instProvider.selectedCount > 1 ? 's' : ''} followed',
                style: AppTypography.bodyBold(
                  fontSize: 15.2,
                  color: AppColors.primaryOrange,
                ),
              ),
              CustomButton(
                text: 'Continue',
                width: 200,
                height: 50,
                borderRadius: BorderRadius.circular(25),
                trailingIcon: const Icon(Icons.arrow_forward_rounded, size: 18),
                onPressed: () {
                  final cdProvider = context.read<ClassDivisionProvider>();
                  cdProvider.syncWithFollowedInstitutions(
                    instProvider.followedInstitutions.map((i) => i.name).toList(),
                  );
                  Navigator.pushNamed(context, AppRoutes.selectClassDivision);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
