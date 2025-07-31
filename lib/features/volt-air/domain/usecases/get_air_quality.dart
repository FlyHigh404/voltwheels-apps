import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/core/usecase/usecase.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/entities/air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/repositories/air_quality_repository.dart';

class GetAirQuality
    implements AirQualityCase<AirQualityResponse, AirQualityParams> {
  AirQualityRepository airQualityRepository;

  GetAirQuality(this.airQualityRepository);

  @override
  Future<Either<Failure, AirQualityResponse>> call(
      AirQualityParams params) async {
    return await airQualityRepository.getAirQualityData(params);
  }
}

class AirQualityParams {
  String latitude;
  String longitude;

  AirQualityParams({required this.latitude, required this.longitude});
}
