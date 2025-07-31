import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/pages/onboarding_pages.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Assets.appLogo,
      nextRoute: '/onboarding',
      splashTransition: SplashTransition.fadeTransition,
      duration: 1000,
      nextScreen: const OnboardingPage(),
    );
  }
}
