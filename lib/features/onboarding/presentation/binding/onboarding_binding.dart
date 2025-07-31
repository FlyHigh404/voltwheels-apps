import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/usecases/get_onboarding_content.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:voltwheels_mobile/init_dependencies.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OnboardingController(
        GetOnboardingContent(
          serviceLocator(),
        ),
      ),
    );
  }
}
