import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../providers/workspace_provider.dart';

/// Step 2: Admin Details form matching create-workspace.html & create-workspace.css #step2Block
class WorkspaceStep2Form extends StatelessWidget {
  final WorkspaceProvider wsProvider;
  final bool isDesktop;

  const WorkspaceStep2Form({
    super.key,
    required this.wsProvider,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final col1 = [
      CustomTextField(
        label: 'Full Name',
        hintText: 'enter display name for dashboard',
        controller: wsProvider.adminFullNameController,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateAdminFullName,
      ),
      const SizedBox(height: 24),
      CustomTextField(
        label: 'Email',
        hintText: 'enter email address',
        controller: wsProvider.adminEmailController,
        keyboardType: TextInputType.emailAddress,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateAdminEmail,
      ),
    ];

    final col2 = [
      CustomDropdownField(
        label: 'Select Designation',
        placeholder: 'select designation',
        selectedValue: wsProvider.adminDesignation,
        options: wsProvider.designations,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.selectDesignation,
      ),
      const SizedBox(height: 24),
      CustomTextField(
        label: 'Mobile Number',
        hintText: 'enter mobile number',
        controller: wsProvider.adminMobileController,
        keyboardType: TextInputType.phone,
        isRequired: true,
        height: 48,
        borderRadius: 10,
        borderColor: const Color(0xFFCBD5E1),
        asteriskColor: const Color(0xFFEF4444),
        onChanged: wsProvider.updateAdminMobile,
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

        // Action Row: Back & Create Workspace Buttons (.step2-actions)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Back Button (.btn-workspace-back)
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: wsProvider.goToStep1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: Center(
                      child: Text(
                        'Back',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Create Workspace Button (.btn-workspace-next)
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
                    wsProvider.submitWorkspace();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52),
                    child: Center(
                      child: Text(
                        'Create Workspace',
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
