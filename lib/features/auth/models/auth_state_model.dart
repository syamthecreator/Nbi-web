import '../../../shared/models/user_model.dart';
import '../../../shared/models/user_role.dart';

enum SignupStep {
  form,
  otp,
  success,
}

/// Immutable state container for authentication flow.
class AuthStateModel {
  final SignupStep currentStep;
  final String fullName;
  final String email;
  final String phone;
  final bool termsAgreed;
  final List<String> otpDigits;
  final int resendCountdown;
  final bool canResendOtp;
  final bool isLoading;
  final String? errorMessage;
  final UserRole selectedRole;
  final UserModel? verifiedUser;

  const AuthStateModel({
    this.currentStep = SignupStep.form,
    this.fullName = 'Rahul Sharma',
    this.email = 'email@gmail.com',
    this.phone = '8787878888',
    this.termsAgreed = true,
    this.otpDigits = const ['', '', '', ''],
    this.resendCountdown = 30,
    this.canResendOtp = false,
    this.isLoading = false,
    this.errorMessage,
    this.selectedRole = UserRole.institution,
    this.verifiedUser,
  });

  AuthStateModel copyWith({
    SignupStep? currentStep,
    String? fullName,
    String? email,
    String? phone,
    bool? termsAgreed,
    List<String>? otpDigits,
    int? resendCountdown,
    bool? canResendOtp,
    bool? isLoading,
    String? errorMessage,
    UserRole? selectedRole,
    UserModel? verifiedUser,
  }) {
    return AuthStateModel(
      currentStep: currentStep ?? this.currentStep,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      termsAgreed: termsAgreed ?? this.termsAgreed,
      otpDigits: otpDigits ?? this.otpDigits,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedRole: selectedRole ?? this.selectedRole,
      verifiedUser: verifiedUser ?? this.verifiedUser,
    );
  }
}
