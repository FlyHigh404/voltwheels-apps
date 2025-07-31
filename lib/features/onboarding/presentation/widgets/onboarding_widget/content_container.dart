import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/controller/onboarding_controller.dart';

import '../gradient_text.dart';
import 'navigation_button.dart';

class ContentContainer extends GetView<OnboardingController> {
  final String? title;
  final String? description;
  final String? label;
  final int index;

  const ContentContainer({
    super.key,
    this.title,
    this.description,
    this.label,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.55,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              GradientText(
                title ?? '',
                gradient: AppPallete.primaryGradient,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                description ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                label ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppPallete.blackGrayColor),
              ),
              const SizedBox(height: 90),
              DotsIndicator(
                dotsCount: 3,
                position: controller.activeIndex.value,
                onTap: (int index) {
                  controller.updateIndex(index);
                  controller.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(24.0, 9.0),
                  color: AppPallete.dotColor,
                  activeColor: AppPallete.primaryColor,
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              NavigationButtons(index: index),
            ],
          ),
        ),
      ),
    );
  }
}
