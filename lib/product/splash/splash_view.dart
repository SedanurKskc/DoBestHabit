import 'package:flutter/material.dart';
import '../auth/auth_view.dart';
import '../home/home_view.dart';
import '../onboarding/onboarding_view.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewmodel {
  @override
  Widget build(BuildContext context) {
    if (isFirstOpen) return  OnboardingView();
    if (userLoggedIn) return  HomeView();
    return const AuthView();
  }
}
