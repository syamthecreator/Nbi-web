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
