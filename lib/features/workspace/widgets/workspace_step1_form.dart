import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../providers/workspace_provider.dart';
import 'school_logo_dropzone.dart';

/// Step 1: Institution Details form matching create-workspace.html & create-workspace.css #step1Block
class WorkspaceStep1Form extends StatelessWidget {
  final WorkspaceProvider wsProvider;
  final bool isDesktop;

  const WorkspaceStep1Form({
    super.key,
    required this.wsProvider,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final col1 = [
      CustomTextField(
        label: 'School / Institution Name',
        hintText: 'enter institution name',
        controller: wsProvider.institutionNameController,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateInstitutionName,
      ),
      const SizedBox(height: 24),
      CustomDropdownField(
        label: 'Institution Type',
        placeholder: 'select institution type',
        selectedValue: wsProvider.institutionType,
        options: wsProvider.institutionTypes,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.selectInstitutionType,
      ),
      const SizedBox(height: 24),
      SchoolLogoDropzone(wsProvider: wsProvider),
    ];

    final col2 = [
      CustomTextField(
        label: 'Workspace Name',
        hintText: 'enter workspace name',
        controller: wsProvider.workspaceNameController,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateWorkspaceName,
      ),
      const SizedBox(height: 24),
      CustomTextField(
        label: 'Institution Code',
        hintText: 'enter institution code',
        controller: wsProvider.institutionCodeController,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateInstitutionCode,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: col1)),
              const SizedBox(width: 48),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: col2)),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...col1, const SizedBox(height: 24), ...col2],
          ),
        const SizedBox(height: 32),

        // Action Row: Next Button (matching create-workspace.css .btn-workspace-next)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFF5A00),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    wsProvider.goToStep2();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52),
                    child: Center(
                      child: Text(
                        'Next',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
