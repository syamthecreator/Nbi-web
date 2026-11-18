/// Enum representing the primary roles in Notice Board India.
enum UserRole {
  institution,
  teacher,
  parent,
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.institution:
        return 'institution';
      case UserRole.teacher:
        return 'teacher';
      case UserRole.parent:
        return 'parent';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.institution:
        return 'Institution';
      case UserRole.teacher:
        return 'Teacher / Staff';
      case UserRole.parent:
        return 'Parent / Student';
    }
  }

  String get tagLine {
    switch (this) {
      case UserRole.institution:
        return 'Admins & Management';
      case UserRole.teacher:
        return 'Teachers & Staff Members';
      case UserRole.parent:
        return 'Parents & Students';
    }
  }

  String get description {
    switch (this) {
      case UserRole.institution:
        return 'I manage the overall operations, staff, students and institutional activities.';
      case UserRole.teacher:
        return 'I manage classes, create posts, track student progress and engage with students.';
      case UserRole.parent:
        return 'I want to stay updated on my child\'s academic progress and institution activities.';
    }
  }

  static UserRole fromString(String? val) {
    if (val == 'teacher') return UserRole.teacher;
    if (val == 'parent') return UserRole.parent;
    return UserRole.institution;
  }
}
