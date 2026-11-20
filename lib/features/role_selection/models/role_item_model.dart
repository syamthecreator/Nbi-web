import 'package:flutter/material.dart';
import '../../../shared/models/user_role.dart';

/// Presentation model for each role card on the Choose Your Role screen.
class RoleItemModel {
  final UserRole role;
  final String title;
  final String description;
  final String tagText;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color tagBgColor;
  final Color tagColor;

  const RoleItemModel({
    required this.role,
    required this.title,
    required this.description,
    required this.tagText,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.tagBgColor,
    required this.tagColor,
  });

  RoleItemModel copyWith({
    UserRole? role,
    String? title,
    String? description,
    String? tagText,
    IconData? icon,
    Color? iconBgColor,
    Color? iconColor,
    Color? tagBgColor,
    Color? tagColor,
  }) {
    return RoleItemModel(
      role: role ?? this.role,
      title: title ?? this.title,
      description: description ?? this.description,
      tagText: tagText ?? this.tagText,
      icon: icon ?? this.icon,
      iconBgColor: iconBgColor ?? this.iconBgColor,
      iconColor: iconColor ?? this.iconColor,
      tagBgColor: tagBgColor ?? this.tagBgColor,
      tagColor: tagColor ?? this.tagColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role.value,
      'title': title,
      'description': description,
      'tagText': tagText,
      'iconCodePoint': icon.codePoint,
      'iconBgColor': iconBgColor.toARGB32(),
      'iconColor': iconColor.toARGB32(),
      'tagBgColor': tagBgColor.toARGB32(),
      'tagColor': tagColor.toARGB32(),
    };
  }

  static IconData _iconForRole(UserRole role) {
    switch (role) {
      case UserRole.institution:
        return Icons.school_outlined;
      case UserRole.teacher:
        return Icons.person_outline;
      case UserRole.parent:
        return Icons.people_alt_outlined;
    }
  }

  factory RoleItemModel.fromJson(Map<String, dynamic> json) {
    final parsedRole = UserRoleExtension.fromString(json['role'] as String?);
    return RoleItemModel(
      role: parsedRole,
      title: json['title'] as String,
      description: json['description'] as String,
      tagText: json['tagText'] as String,
      icon: _iconForRole(parsedRole),
      iconBgColor: Color(json['iconBgColor'] as int? ?? 0xFFFFEADF),
      iconColor: Color(json['iconColor'] as int? ?? 0xFFFF5A00),
      tagBgColor: Color(json['tagBgColor'] as int? ?? 0xFFFFEADF),
      tagColor: Color(json['tagColor'] as int? ?? 0xFFD94800),
    );
  }

  static List<RoleItemModel> defaultRoles() => const [
        RoleItemModel(
          role: UserRole.institution,
          title: 'Institution',
          description: 'I manage the overall operations, staff, students and institutional activities.',
          tagText: 'Admins & Management',
          icon: Icons.school_outlined,
          iconBgColor: Color(0xFFFFEADF),
          iconColor: Color(0xFFFF5A00),
          tagBgColor: Color(0xFFFFEADF),
          tagColor: Color(0xFFD94800),
        ),
        RoleItemModel(
          role: UserRole.teacher,
          title: 'Teacher / Staff',
          description: 'I manage classes, create posts, track student progress and engage with students.',
          tagText: 'Teachers & Staff Members',
          icon: Icons.person_outline,
          iconBgColor: Color(0xFFE0F2FE),
          iconColor: Color(0xFF0284C7),
          tagBgColor: Color(0xFFE0F2FE),
          tagColor: Color(0xFF0369A1),
        ),
        RoleItemModel(
          role: UserRole.parent,
          title: 'Parent / Student',
          description: 'I want to stay updated on my child\'s academic progress and institution activities.',
          tagText: 'Parents & Students',
          icon: Icons.people_alt_outlined,
          iconBgColor: Color(0xFFDCFCE7),
          iconColor: Color(0xFF16A34A),
          tagBgColor: Color(0xFFDCFCE7),
          tagColor: Color(0xFF15803D),
        ),
      ];
}
