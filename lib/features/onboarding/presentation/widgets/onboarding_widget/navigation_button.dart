import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class NavigationButtons extends GetView<OnboardingController> {
  final int index;

  const NavigationButtons({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return controller.activeIndex.value == 2
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.blackGrayColor, width: 0.5),
              borderRadius: BorderRadius.circular(52),
            ),
            child: SlideAction(
              height: 65,
              sliderButtonYOffset: -4,
              sliderButtonIconPadding: 22,
              sliderRotate: false,
              text: 'Geser untuk mulai',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppPallete.sliderTextColor,
                  ),
              innerColor: AppPallete.primaryColor,
              elevation: 2,
              outerColor: AppPallete.whiteColor,
              submittedIcon: const Icon(
                Icons.check_circle,
                color: AppPallete.primaryColor,
              ),
              onSubmit: () async {
                Get.toNamed(RouteName.login);
              },
              sliderButtonIcon: Image.asset(
                Assets.nextIcon,
                width: 15,
                height: 15,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.updateIndex(2);
                  controller.pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (index < 2) {
                    controller.updateIndex(index + 1);
                    controller.pageController.animateToPage(
                      index + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Row(
                  children: [
                    Text(
                      'Next',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: AppPallete.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
