import 'package:fpdart/fpdart.dart';

import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/entities/onboarding.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

import 'package:voltwheels_mobile/core/error/failures.dart';

class GetOnboardingContent extends OnboardingCase<List<Onboarding>> {
  OnboardingRepository onboardingRepository;

  GetOnboardingContent(this.onboardingRepository);

  @override
  Either<Failure, List<Onboarding>> call() {
    return onboardingRepository.getOnboardingContent();
  }
}
