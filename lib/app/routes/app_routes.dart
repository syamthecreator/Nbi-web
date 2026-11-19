import 'package:flutter/material.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/class_division/screens/select_class_division_screen.dart';
import '../../features/feed/screens/school_feed_screen.dart';
import '../../features/institution/screens/select_institution_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/role_selection/screens/select_role_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/workspace/screens/create_workspace_screen.dart';

/// App Routes - Named routes centralized mapping for the application.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String selectRole = '/select-role';
  static const String signup = '/signup';
  static const String createWorkspace = '/create-workspace';
  static const String selectInstitution = '/select-institution';
  static const String selectClassDivision = '/select-class-division';
  static const String schoolFeed = '/school-feed';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    selectRole: (context) => const SelectRoleScreen(),
    signup: (context) => const SignupScreen(),
    createWorkspace: (context) => const CreateWorkspaceScreen(),
    selectInstitution: (context) => const SelectInstitutionScreen(),
    selectClassDivision: (context) => const SelectClassDivisionScreen(),
    schoolFeed: (context) => const SchoolFeedScreen(initialSection: AppRoutes.schoolFeed),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
  };
}
