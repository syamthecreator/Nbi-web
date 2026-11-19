import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/background_shapes.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_logo_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateToNext(BuildContext context) {
    context.read<SplashProvider>().cancelSplashTimer();
    Navigator.pushReplacementNamed(context, AppRoutes.selectRole);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<SplashProvider>().startSplashTimer(() {
          if (context.mounted && ModalRoute.of(context)?.isCurrent == true) {
            _navigateToNext(context);
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: InkWell(
        onTap: () => _navigateToNext(context),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Stack(
          children: [
            // Organic Background Shapes (Top-Left & Bottom-Right)
            const BackgroundShapes(showTopLeft: true, showBottomRight: true),

            // Center Content
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SplashLogoView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
