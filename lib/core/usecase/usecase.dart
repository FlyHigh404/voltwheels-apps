import 'package:fpdart/fpdart.dart';

import 'package:voltwheels_mobile/core/error/failures.dart';

abstract class UserCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

abstract class OnboardingCase<SuccessType> {
  Either<Failure, SuccessType> call();
}

abstract class AirQualityCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

abstract class VoltRentOrderCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
