import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/profile_provider.dart';

/// Modal dialog for editing profile information matching source_nbi
/// (.edit-profile-modal-overlay, .edit-profile-modal-card, .edit-modal-header, .edit-modal-form)
class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPhoneFocused = false;

  bool _isNameHovered = false;
  bool _isEmailHovered = false;
  bool _isPhoneHovered = false;

  bool _isCloseHovered = false;
  bool _isCancelHovered = false;
  bool _isSaveHovered = false;

  String? _errorMessage;

  late final VoidCallback _nameFocusListener;
  late final VoidCallback _emailFocusListener;
  late final VoidCallback _phoneFocusListener;

  @override
  void initState() {
    super.initState();
    final profileProvider = context.read<ProfileProvider>();
    _nameController = TextEditingController(text: profileProvider.fullName);
    _emailController = TextEditingController(text: profileProvider.email);
    _phoneController = TextEditingController(text: profileProvider.phone);

    _nameFocusListener = () {
      if (mounted) setState(() => _isNameFocused = _nameFocusNode.hasFocus);
    };
    _emailFocusListener = () {
      if (mounted) setState(() => _isEmailFocused = _emailFocusNode.hasFocus);
    };
    _phoneFocusListener = () {
      if (mounted) setState(() => _isPhoneFocused = _phoneFocusNode.hasFocus);
    };

    _nameFocusNode.addListener(_nameFocusListener);
    _emailFocusNode.addListener(_emailFocusListener);
    _phoneFocusNode.addListener(_phoneFocusListener);
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_nameFocusListener);
    _emailFocusNode.removeListener(_emailFocusListener);
    _phoneFocusNode.removeListener(_phoneFocusListener);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _handleSave(ProfileProvider profileProvider) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all profile fields.';
      });
      return;
    }

    final success = profileProvider.saveProfile(
      name: name,
      email: email,
      phone: phone,
    );

    if (success) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Profile updated successfully!'),
          backgroundColor: Color(0xFF10B981),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleCancel(ProfileProvider profileProvider) {
    profileProvider.closeEditModal();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000), // rgba(0, 0, 0, 0.2)
                blurRadius: 50,
                offset: Offset(0, 20),
              ),
            ],
          ),
          padding: const EdgeInsets.all(28),
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (.edit-modal-header)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('✏️', style: TextStyle(fontSize: 22)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Edit Profile Information',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18.4,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF111111),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Update your personal account details',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Close button (.btn-close-modal)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) =>
                              setState(() => _isCloseHovered = true),
                          onExit: (_) =>
                              setState(() => _isCloseHovered = false),
                          child: GestureDetector(
                            onTap: () => _handleCancel(profileProvider),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _isCloseHovered
                                    ? const Color(0xFFE5E7EB)
                                    : const Color(0xFFF3F4F6),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '✕',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _isCloseHovered
                                      ? const Color(0xFF111111)
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: Color(0xFFF3F4F6), height: 1),
                    const SizedBox(height: 20),

                    // Validation Error Alert if present
                    if (_errorMessage != null) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFFCA5A5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 16,
                              color: Color(0xFFDC2626),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFDC2626),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Field 1: Full Name *
                    Text(
                      'Full Name *',
                      style: GoogleFonts.inter(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 6),
                    MouseRegion(
                      onEnter: (_) => setState(() => _isNameHovered = true),
                      onExit: (_) => setState(() => _isNameHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _isNameFocused
                              ? Colors.white
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isNameFocused
                                ? AppColors.primaryOrange
                                : (_isNameHovered
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFFE5E7EB)),
                            width: 1.5,
                          ),
                          boxShadow: _isNameFocused
                              ? const [
                                  BoxShadow(
                                    color: Color(
                                      0x1FFF6000,
                                    ), // rgba(255, 96, 0, 0.12)
                                    spreadRadius: 3,
                                    blurRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                        child: TextField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          cursorColor: AppColors.primaryOrange,
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111111),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            filled: false,
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 11,
                            ),
                            hintText: 'Rahul Sharma',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14.4,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF9CA3AF),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 2: Registered Email *
                    Text(
                      'Registered Email *',
                      style: GoogleFonts.inter(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 6),
                    MouseRegion(
                      onEnter: (_) => setState(() => _isEmailHovered = true),
                      onExit: (_) => setState(() => _isEmailHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _isEmailFocused
                              ? Colors.white
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isEmailFocused
                                ? AppColors.primaryOrange
                                : (_isEmailHovered
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFFE5E7EB)),
                            width: 1.5,
                          ),
                          boxShadow: _isEmailFocused
                              ? const [
                                  BoxShadow(
                                    color: Color(
                                      0x1FFF6000,
                                    ), // rgba(255, 96, 0, 0.12)
                                    spreadRadius: 3,
                                    blurRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                        child: TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: AppColors.primaryOrange,
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111111),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            filled: false,
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 11,
                            ),
                            hintText: 'email@gmail.com',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14.4,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF9CA3AF),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 3: Contact / Phone Number * (.modal-phone-wrapper)
                    Text(
                      'Contact / Phone Number *',
                      style: GoogleFonts.inter(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 6),
                    MouseRegion(
                      onEnter: (_) => setState(() => _isPhoneHovered = true),
                      onExit: (_) => setState(() => _isPhoneHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 46,
                        decoration: BoxDecoration(
                          color: _isPhoneFocused
                              ? Colors.white
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isPhoneFocused
                                ? AppColors.primaryOrange
                                : (_isPhoneHovered
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFFE5E7EB)),
                            width: 1.5,
                          ),
                          boxShadow: _isPhoneFocused
                              ? const [
                                  BoxShadow(
                                    color: Color(
                                      0x1FFF6000,
                                    ), // rgba(255, 96, 0, 0.12)
                                    spreadRadius: 3,
                                    blurRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          children: [
                            // Country Prefix (.modal-country-prefix)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3F4F6),
                                border: Border(
                                  right: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '🇮🇳 +91',
                                style: GoogleFonts.inter(
                                  fontSize: 14.4,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                            ),

                            // Inner phone input field
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                focusNode: _phoneFocusNode,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                cursorColor: AppColors.primaryOrange,
                                style: GoogleFonts.inter(
                                  fontSize: 14.4,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF111111),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  filled: false,
                                  fillColor: Colors.transparent,
                                  isDense: true,
                                  counterText: '',
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 11,
                                  ),
                                  hintText: '8787878888',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 14.4,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Actions: Cancel & Save Changes (.edit-modal-actions)
                    const Divider(color: Color(0xFFF3F4F6), height: 1),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancel Button (.btn-cancel-modal)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) =>
                              setState(() => _isCancelHovered = true),
                          onExit: (_) =>
                              setState(() => _isCancelHovered = false),
                          child: GestureDetector(
                            onTap: () => _handleCancel(profileProvider),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: _isCancelHovered
                                    ? const Color(0xFFE5E7EB)
                                    : const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: _isCancelHovered
                                      ? const Color(0xFF111111)
                                      : const Color(0xFF374151),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Save Changes Button (.btn-save-modal)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isSaveHovered = true),
                          onExit: (_) => setState(() => _isSaveHovered = false),
                          child: GestureDetector(
                            onTap: () => _handleSave(profileProvider),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              transform: _isSaveHovered
                                  ? Matrix4.translationValues(0, -1, 0)
                                  : Matrix4.identity(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: _isSaveHovered
                                    ? const Color(0xFFE04E00)
                                    : AppColors.primaryOrange,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40FF5A00),
                                    blurRadius: _isSaveHovered ? 16 : 12,
                                    offset: Offset(0, _isSaveHovered ? 6 : 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.save_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Save Changes',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
