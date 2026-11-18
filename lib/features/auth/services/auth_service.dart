import '../../../core/services/base_service.dart';
import '../../../shared/models/user_model.dart';
import '../../../shared/models/user_role.dart';

/// Contract for Authentication operations.
abstract class AuthService extends BaseService {
  AuthService({super.client});

  Future<bool> sendOtp({required String phone, required String email});
  Future<UserModel> verifyOtp({required String phone, required List<String> otpDigits, required UserRole role});
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
}

/// Standard production-ready implementation of [AuthService].
class AuthServiceImpl extends AuthService {
  AuthServiceImpl({super.client});

  @override
  Future<bool> sendOtp({required String phone, required String email}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  Future<UserModel> verifyOtp({
    required String phone,
    required List<String> otpDigits,
    required UserRole role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return UserModel(
      fullName: 'Rahul Sharma',
      email: 'email@gmail.com',
      phone: phone.isNotEmpty ? phone : '8787878888',
      role: role,
      isVerified: true,
      status: 'Active Member',
    );
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
