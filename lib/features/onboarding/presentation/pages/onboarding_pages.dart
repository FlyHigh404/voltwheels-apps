import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/controller/onboarding_controller.dart';

import '../widgets/onboarding_widget/onboarding_widget.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingController onboardingController = controller;

    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            controller: controller.pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              controller.updateIndex(value);
            },
            itemBuilder: (BuildContext context, int index) {
              var onboarding = onboardingController.onboardingContent[index];
              return OnboardingWidget(
                index: onboarding.index,
                title: onboarding.title,
                description: onboarding.description,
                label: onboarding.label,
                image: onboarding.imagePath,
              );
            },
            itemCount: controller.onboardingContent.length,
          );
        },
      ),
    );
  }
}
