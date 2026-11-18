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
}
