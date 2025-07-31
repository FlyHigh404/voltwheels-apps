import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/entities/onboarding.dart';

import 'package:voltwheels_mobile/core/error/failures.dart';

abstract class OnboardingRepository {
  Either<Failure, List<Onboarding>> getOnboardingContent();
}
