import '../../../shared/models/user_model.dart';
import '../../../shared/models/user_role.dart';
import '../services/auth_service.dart';

abstract class AuthRepository {
  Future<bool> sendOtp({required String phone, required String email});
  Future<UserModel> verifyOtp({required String phone, required List<String> otpDigits, required UserRole role});
  Future<UserModel?> getCachedUser();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({AuthService? service})
      : authService = service ?? AuthServiceImpl();

  @override
  Future<bool> sendOtp({required String phone, required String email}) {
    return authService.sendOtp(phone: phone, email: email);
  }

  @override
  Future<UserModel> verifyOtp({
    required String phone,
    required List<String> otpDigits,
    required UserRole role,
  }) {
    return authService.verifyOtp(phone: phone, otpDigits: otpDigits, role: role);
  }

  @override
  Future<UserModel?> getCachedUser() {
    return authService.getCurrentUser();
  }

  @override
  Future<void> logout() {
    return authService.logout();
  }
}
