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

  Map<String, dynamic> toJson() {
    return {
      'currentStep': currentStep.index,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'termsAgreed': termsAgreed,
      'otpDigits': otpDigits,
      'resendCountdown': resendCountdown,
      'canResendOtp': canResendOtp,
      'isLoading': isLoading,
      'errorMessage': errorMessage,
      'selectedRole': selectedRole.value,
      'verifiedUser': verifiedUser?.toJson(),
    };
  }

  factory AuthStateModel.fromJson(Map<String, dynamic> json) {
    return AuthStateModel(
      currentStep: SignupStep.values[json['currentStep'] as int? ?? 0],
      fullName: json['fullName'] as String? ?? 'Rahul Sharma',
      email: json['email'] as String? ?? 'email@gmail.com',
      phone: json['phone'] as String? ?? '8787878888',
      termsAgreed: json['termsAgreed'] as bool? ?? true,
      otpDigits: (json['otpDigits'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['', '', '', ''],
      resendCountdown: json['resendCountdown'] as int? ?? 30,
      canResendOtp: json['canResendOtp'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      selectedRole: UserRoleExtension.fromString(json['selectedRole'] as String?),
      verifiedUser: json['verifiedUser'] != null
          ? UserModel.fromJson(json['verifiedUser'] as Map<String, dynamic>)
          : null,
    );
  }
}
