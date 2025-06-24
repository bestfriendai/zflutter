import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortzz/common/controller/base_controller.dart';
import 'package:shortzz/common/manager/session_manager.dart';
import 'package:shortzz/model/general/settings_model.dart';
import 'package:shortzz/screen/auth_screen/login_screen.dart';

class OnBoardingScreenController extends BaseController {
  PageController pageController = PageController();
  RxInt selectedPage = RxInt(0);

  RxList<OnBoarding> onBoardingData = <OnBoarding>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchOnBoarding();
  }

  void _fetchOnBoarding() {
    List<OnBoarding> onBoardingList =
        SessionManager.instance.getSettings()?.onBoarding ?? [];

    if (onBoardingList.isEmpty) {
      // If no onboarding data is available, redirect to login screen
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.off(() => const LoginScreen());
      });
      return;
    }

    for (var element in onBoardingList) {
      onBoardingData.add(element);
    }
  }

  void onPageChanged(int value) {
    selectedPage.value = value;
  }

  void onNextTap() {
    if (selectedPage.value < onBoardingData.length - 1) {
      selectedPage.value++;
      pageController.animateToPage(
        selectedPage.value,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    } else if (selectedPage.value == onBoardingData.length - 1) {
      Get.off(() => const LoginScreen());
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
