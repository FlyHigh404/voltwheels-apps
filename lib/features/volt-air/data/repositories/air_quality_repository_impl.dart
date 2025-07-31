import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/core/error/failures.dart';
import 'package:voltwheels_mobile/features/volt-air/data/datasources/air_quality_remote_datasource.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/repositories/air_quality_repository.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_forecast.dart';

import '../../domain/entities/air_quality.dart';

class AirQualityRepositoryImpl implements AirQualityRepository {
  final AirQualityRemoteDatasource _remoteDatasource;

  AirQualityRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, AirQualityResponse>> getAirQualityData(
      AirQualityParams params) {
    return _fetchData(
        () async => await _remoteDatasource.getAirQualityData(params),
        'fetching air quality data');
  }

  @override
  Future<Either<Failure, AirQualityResponse>> getForecastAirQualityData(
      ForeCastAirQualityParams params) {
    return _fetchData(
        () async => await _remoteDatasource.getForecastAirQualityData(params),
        'fetching forecast air quality data');
  }

  Future<Either<Failure, AirQualityResponse>> _fetchData(
    Future<AirQualityResponse?> Function() getData,
    String actionDescription,
  ) async {
    try {
      final response = await getData();
      if (response == null) {
        throw const CustomException('No data received');
      }
      return right(response);
    } on DioException catch (e) {
      return left(Failure(
          e.message ?? 'Error $actionDescription: DioException occurred'));
    } on CustomException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(
          'Error $actionDescription: Unexpected error ${e.toString()}'));
    }
  }
}
