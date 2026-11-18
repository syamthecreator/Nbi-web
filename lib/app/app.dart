import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/class_division/providers/class_division_provider.dart';
import '../features/feed/providers/feed_provider.dart';
import '../features/institution/providers/institution_provider.dart';
import '../features/profile/providers/profile_provider.dart';
import '../features/role_selection/providers/role_provider.dart';
import '../features/settings/providers/settings_provider.dart';
import '../features/splash/providers/splash_provider.dart';
import '../features/workspace/providers/workspace_provider.dart';
import '../shared/providers/global_provider.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

/// Root Application Widget with MultiProvider state management.
/// Complete separation of concerns: UI, Providers, Repositories, Services, Models.
/// Strict Zero setState().
class NbiApp extends StatelessWidget {
  const NbiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WorkspaceProvider()),
        ChangeNotifierProvider(create: (_) => InstitutionProvider()),
        ChangeNotifierProvider(create: (_) => ClassDivisionProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: 'NBI – Notice Board India',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
