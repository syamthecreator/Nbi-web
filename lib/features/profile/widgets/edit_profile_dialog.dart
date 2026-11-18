import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../providers/profile_provider.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.bgWhite,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modal Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('✏️ ', style: TextStyle(fontSize: 22)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Profile Information',
                                style: AppTypography.heading3(fontSize: 16),
                              ),
                              Text(
                                'Update your personal account details',
                                style: AppTypography.caption(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: profileProvider.closeEditModal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.borderLight, height: 1),
                  const SizedBox(height: 20),

                  // Fields
                  CustomTextField(
                    label: 'Full Name',
                    hintText: 'Rahul Sharma',
                    initialValue: profileProvider.editFullName,
                    isRequired: true,
                    onChanged: profileProvider.updateEditFullName,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'Registered Email',
                    hintText: 'email@gmail.com',
                    initialValue: profileProvider.editEmail,
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: profileProvider.updateEditEmail,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'Contact / Phone Number',
                    hintText: '8787878888',
                    initialValue: profileProvider.editPhone,
                    isRequired: true,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    onChanged: profileProvider.updateEditPhone,
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: profileProvider.closeEditModal,
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      CustomButton(
                        text: 'Save Changes',
                        width: 140,
                        height: 44,
                        onPressed: () {
                          if (profileProvider.saveProfile()) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
