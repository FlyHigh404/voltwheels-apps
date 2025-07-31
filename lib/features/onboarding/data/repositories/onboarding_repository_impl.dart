import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/entities/onboarding.dart';
import 'package:voltwheels_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

import 'package:voltwheels_mobile/core/error/failures.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDatasource onboardingLocalDatasource;

  OnboardingRepositoryImpl(this.onboardingLocalDatasource);

  @override
  Either<Failure, List<Onboarding>> getOnboardingContent() {
    try {
      List<Onboarding> onboardingList =
          onboardingLocalDatasource.getOnboardingContent();

      return right(onboardingList);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }
}
