import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/entities/air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_forecast.dart';

abstract class AirQualityRepository {
  Future<Either<Failure, AirQualityResponse>> getAirQualityData(
      AirQualityParams params);

  Future<Either<Failure, AirQualityResponse>> getForecastAirQualityData(
      ForeCastAirQualityParams params);
}
