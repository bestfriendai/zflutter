import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortzz/common/widget/custom_shimmer_fill_text.dart';
import 'package:shortzz/common/widget/theme_blur_bg.dart';
import 'package:shortzz/screen/splash_screen/splash_screen_controller.dart';
import 'package:shortzz/utilities/app_res.dart';
import 'package:shortzz/utilities/text_style_custom.dart';
import 'package:shortzz/utilities/theme_res.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('🌟 SPLASH: Building SplashScreen widget...');

    try {
      print('🎮 SPLASH: Creating SplashScreenController...');
      Get.put(SplashScreenController());
      print('✅ SPLASH: SplashScreenController created successfully');

      print('📱 SPLASH: Getting app name from AppRes...');
      final appName = AppRes.appName.toUpperCase();
      print('✅ SPLASH: App name: $appName');

      print('🎨 SPLASH: Getting theme colors...');
      final whiteColor = whitePure(context);
      final accentColor = themeAccentSolid(context);
      print('✅ SPLASH: Theme colors obtained successfully');

      print('🏗️ SPLASH: Building scaffold...');
      return Scaffold(
        body: Stack(
          children: [
            const ThemeBlurBg(),
            Align(
              alignment: Alignment.center,
              child: CustomShimmerFillText(
                text: appName,
                baseColor: whiteColor,
                textStyle: TextStyleCustom.unboundedBlack900(
                    color: whiteColor, fontSize: 30),
                finalColor: whiteColor,
                shimmerColor: accentColor,
              ),
            )
          ],
        ),
      );
    } catch (e, st) {
      print('❌ SPLASH: Error building SplashScreen: $e');
      print('📋 SPLASH: Stack trace: $st');

      // Return a simple fallback splash screen
      return Scaffold(
        body: Container(
          color: Colors.black,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 16),
                Text('Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }
  }
}
