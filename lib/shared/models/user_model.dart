import 'user_role.dart';

/// Strongly-typed User entity for NBI authentication and profile state.
class UserModel {
  final String fullName;
  final String email;
  final String phone;
  final UserRole role;
  final bool isVerified;
  final String status;

  const UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    this.role = UserRole.institution,
    this.isVerified = true,
    this.status = 'Active Member',
  });

  static const UserModel defaultUser = UserModel(
    fullName: 'Rahul Sharma',
    email: 'email@gmail.com',
    phone: '8787878888',
    role: UserRole.institution,
    isVerified: true,
    status: 'Active Member',
  );

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    UserRole? role,
    bool? isVerified,
    String? status,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role.value,
      'isVerified': isVerified,
      'status': status,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: UserRoleExtension.fromString(json['role'] as String?),
      isVerified: json['isVerified'] as bool? ?? false,
      status: json['status'] as String? ?? 'Active Member',
    );
  }
}
