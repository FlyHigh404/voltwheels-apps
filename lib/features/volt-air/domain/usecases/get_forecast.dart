import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/entities/air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/repositories/air_quality_repository.dart';

class GetForecastAirQuality
    implements AirQualityCase<AirQualityResponse, ForeCastAirQualityParams> {
  AirQualityRepository airQualityRepository;

  GetForecastAirQuality(this.airQualityRepository);

  @override
  Future<Either<Failure, AirQualityResponse>> call(params) async {
    return await airQualityRepository.getForecastAirQualityData(params);
  }
}

class ForeCastAirQualityParams {
  String latitude;
  String longitude;
  String startDate;
  String endDate;

  ForeCastAirQualityParams({
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
  });
}
