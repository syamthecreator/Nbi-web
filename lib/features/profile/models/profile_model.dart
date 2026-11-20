/// Entity representing user profile information.
class ProfileModel {
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String avatarUrl;

  const ProfileModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl = 'assets/images/user-avatar.png',
  });

  ProfileModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? role,
    String? avatarUrl,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  static const ProfileModel defaultProfile = ProfileModel(
    fullName: 'Rahul Dev Sharma',
    email: 'rahul.sharma@nbi-school.edu.in',
    phone: '9876543210',
    role: 'Student',
  );

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'avatarUrl': avatarUrl,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String? ?? 'Rahul Dev Sharma',
      email: json['email'] as String? ?? 'rahul.sharma@nbi-school.edu.in',
      phone: json['phone'] as String? ?? '9876543210',
      role: json['role'] as String? ?? 'Student',
      avatarUrl: json['avatarUrl'] as String? ?? 'assets/images/user-avatar.png',
    );
  }
}
