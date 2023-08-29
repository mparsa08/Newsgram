import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../gen/assets.gen.dart';
import 'onboardingscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.off(() => OnBoardingScreen()));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Assets.img.background.splash.image(
                fit: BoxFit.cover,
              ),
            ),
            Center(child: Assets.img.icons.logo.svg()),
          ],
        ),
      ),
    );
  }
}
