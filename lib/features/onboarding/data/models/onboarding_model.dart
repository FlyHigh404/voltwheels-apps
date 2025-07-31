import 'package:voltwheels_mobile/features/onboarding/domain/entities/onboarding.dart';

class OnboardingModel extends Onboarding {
  OnboardingModel({
    super.title,
    super.description,
    super.imagePath,
    super.label,
    required super.index,
  });
}
