import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/features/onboarding/data/models/onboarding_model.dart';

import 'package:voltwheels_mobile/core/assets/assets.dart';

abstract class OnboardingLocalDatasource {
  List<OnboardingModel> getOnboardingContent();
}

class OnboardingLocalDatasourceImpl implements OnboardingLocalDatasource {
  final List<OnboardingModel> _onboardingContent = [
    OnboardingModel(
      index: 0,
      title: 'Voltwheels',
      description:
          'Solusi untuk kamu yang butuh transportasi tanpa hirup asap ngebul!',
      label: 'Drive Green, Drive Clean, Drive Voltwheels',
      imagePath: Assets.onboarding1,
    ),
    OnboardingModel(
      index: 1,
      title: 'Features',
      description:
          'Nikmati berbagai fitur yang bisa memenuhi kebutuhan mu seharian!',
      label: 'Drive Green, Drive Clean, Drive Voltwheels',
      imagePath: Assets.onboarding2,
    ),
    OnboardingModel(
      index: 2,
      title: 'Comfort',
      description:
          'Enaknya pakai Voltwheels bikin kamu nyaman dan selalu keinget!',
      label: 'Drive Green, Drive Clean, Drive Voltwheels',
      imagePath: Assets.onboarding3,
    ),
  ];

  @override
  List<OnboardingModel> getOnboardingContent() {
    try {
      return _onboardingContent;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
