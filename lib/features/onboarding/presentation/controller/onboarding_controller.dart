import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/entities/onboarding.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/usecases/get_onboarding_content.dart';

class OnboardingController extends GetxController {
  final GetOnboardingContent _getOnboardingContent;
  final PageController pageController = PageController();

  final RxList<Onboarding> onboardingContent = <Onboarding>[].obs;
  final RxInt activeIndex = 0.obs;
  late final String error;

  OnboardingController(this._getOnboardingContent);

  @override
  void onInit() {
    loadContent();

    super.onInit();
  }

  void loadContent() {
    final result = _getOnboardingContent();

    result.fold(
      (fail) => error = fail.message,
      (onboardingList) => onboardingContent.value = onboardingList,
    );
  }

  void updateIndex(int index) {
    activeIndex.value = index;
  }
}
