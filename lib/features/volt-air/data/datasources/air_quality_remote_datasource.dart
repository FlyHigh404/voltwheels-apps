import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:voltwheels_mobile/core/error/exceptions.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_forecast.dart';

import '../models/air_quality_model.dart';

abstract class AirQualityRemoteDatasource {
  Future<AirQualityResponseModel?> getAirQualityData(AirQualityParams params);

  Future<AirQualityResponseModel?> getForecastAirQualityData(
      ForeCastAirQualityParams params);
}

class AirQualityRemoteDataSourceImpl implements AirQualityRemoteDatasource {
  final Dio _dio = GetIt.instance<Dio>();
  final String _baseUrl = dotenv.env['VOLT_AIR_BASE_URL']!;
  final String _apiKey = dotenv.env['VOLT_AIR_API_KEY']!;

  @override
  Future<AirQualityResponseModel?> getAirQualityData(AirQualityParams params) {
    final endpoint =
        '$_baseUrl?lat=${params.latitude}&lon=${params.longitude}&appId=$_apiKey';
    return _fetchData(endpoint, 'fetching air quality data');
  }

  @override
  Future<AirQualityResponseModel?> getForecastAirQualityData(
      ForeCastAirQualityParams params) {
    final endpoint =
        '$_baseUrl/history?lat=${params.latitude}&lon=${params.longitude}&start=${params.startDate}&end=${params.endDate}&appId=$_apiKey';
    return _fetchData(endpoint, 'fetching forecast air quality data');
  }

  Future<AirQualityResponseModel?> _fetchData(
      String url, String actionDescription) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        log('Success $actionDescription: ${response.data}');
        return AirQualityResponseModel.fromJson(response.data);
      } else {
        throw CustomException(
            'Failed $actionDescription: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw CustomException('Error $actionDescription: ${e.toString()}');
    }
  }
}
