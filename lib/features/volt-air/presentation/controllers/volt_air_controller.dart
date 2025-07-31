import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/libs/geocoding.dart';
import 'package:voltwheels_mobile/core/libs/geolocator.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_air_quality.dart';
import 'package:voltwheels_mobile/features/volt-air/domain/usecases/get_forecast.dart';

import '../../domain/entities/air_quality.dart';
import '../utils/aqi_converter.dart';

class VoltAirController extends GetxController {
  final GetAirQuality _getAirQuality;
  final GetForecastAirQuality _getForecastAirQuality;

  late final Rx<AirQualityResponse> currentAirQualityResponse;
  late final Rx<AirQualityResponse> forecastAirQualityResponse;
  late final RxList<AirQualityResponse> nearbyAirQualityResponse;
  late final RxDouble airQualityIndex;
  late final Rx<AirQualityParams> airQualityParams;
  late final Rx<ForeCastAirQualityParams> forecastAirQualityParams;
  late final RxString currentPosition;

  final RxList<String> nearbyLocation = <String>[].obs;

  final Rx<DayOfWeekModel> currentDayOfWeek = DayOfWeekModel(
    date: DateTime.now(),
    dayName: listDays[DateTime.now().weekday - 1],
  ).obs;

  final Rx<Position?> position = Rx<Position?>(null);

  final RxBool activeTab = true.obs;

  final RxBool loadingNearbyAirQuality = false.obs;
  final RxBool loadingForecastAirQuality = false.obs;

  VoltAirController(this._getAirQuality, this._getForecastAirQuality);

  @override
  void onInit() {
    airQualityParams = AirQualityParams(latitude: '', longitude: '').obs;
    forecastAirQualityParams = ForeCastAirQualityParams(
      latitude: '',
      longitude: '',
      startDate: dateTimeToUnix(currentDayOfWeek.value.date).toString(),
      endDate: dateTimeToUnix(
        currentDayOfWeek.value.date.add(
          const Duration(days: 1),
        ),
      ).toString(),
    ).obs;
    currentAirQualityResponse = AirQualityResponse(
      coord: Coord(lon: 0, lat: 0),
      list: [],
    ).obs;
    nearbyAirQualityResponse = <AirQualityResponse>[].obs;
    airQualityIndex = 0.0.obs;
    currentPosition = ''.obs;
    forecastAirQualityResponse = AirQualityResponse(
      coord: Coord(lon: 0, lat: 0),
      list: [],
    ).obs;

    getCurrentPosition();

    super.onInit();
  }

  void updateActiveTab(bool value) {
    activeTab.value = value;
  }

  void updateLoadingNearby(bool value) {
    loadingNearbyAirQuality.value = value;
  }

  void updateLoadingForecast(bool value) {
    loadingForecastAirQuality.value = value;
  }

  Future<void> fetchCurrentAirQuality() async {
    final response = await _getAirQuality(airQualityParams.value);

    response.fold(
      (fail) => print('Fail : ${fail.message}'),
      (airQualityResponse) {
        currentAirQualityResponse.value = airQualityResponse;

        var component = airQualityResponse.list.first.components;

        AQICalculator aqiCalculator = AQICalculator(
          pm25: component.pm2_5,
          pm10: component.pm10,
          co: component.co,
          so2: component.so2,
          no2: component.no2,
        );

        airQualityIndex.value = aqiCalculator.calculateOverallAQI();
      },
    );
  }

  Future<void> fetchNearbyAirQuality(AirQualityParams params) async {
    final response = await _getAirQuality(params);

    response.fold(
      (fail) => print('Fail : ${fail.message}'),
      (airQualityResponse) {
        nearbyAirQualityResponse.add(airQualityResponse);
      },
    );
  }

  Future<void> fetchForecastAirQuality() async {
    updateLoadingForecast(true);
    final response =
        await _getForecastAirQuality(forecastAirQualityParams.value);

    response.fold(
      (fail) => print('Fail : ${fail.message}'),
      (airQualityResponse) {
        forecastAirQualityResponse.value = airQualityResponse;
      },
    );

    updateLoadingForecast(false);
  }

  void getCurrentPosition() async {
    EasyLoading.show(status: 'Loading');
    final position = await GeolocatorLib.determinePosition();
    this.position.value = position;

    airQualityParams.value = AirQualityParams(
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString(),
    );

    forecastAirQualityParams.value.longitude = position.longitude.toString();

    forecastAirQualityParams.value.latitude = position.latitude.toString();

    currentPosition.value =
        (await getAddressFromLatLng(position.latitude, position.longitude)) ??
            "Indonesia";

    await fetchCurrentAirQuality();

    EasyLoading.dismiss();

    getNearbyPosition();

    fetchForecastAirQuality();
  }

  void updateDaysOfWeek(DayOfWeekModel value) {
    currentDayOfWeek.value = value;

    forecastAirQualityParams.value.startDate =
        dateTimeToUnix(value.date).toString();
    forecastAirQualityParams.value.endDate =
        dateTimeToUnix(value.date.add(const Duration(days: 1))).toString();

    fetchForecastAirQuality();
  }

  Future<void> getNearbyPosition() async {
    nearbyLocation.clear();
    nearbyAirQualityResponse.clear();

    updateLoadingNearby(true);

    List<CustomPosition> nearby = getNearbyCoordinates(
      position.value!,
      4,
      15000,
    );

    for (var e in nearby) {
      String? address =
          await getAddressFromLatLng(e.lat, e.lon, returnSubLocality: true);

      print("success get $address");

      if (address != null) {
        nearbyLocation.add(address);

        await fetchNearbyAirQuality(
          AirQualityParams(
            latitude: e.lat.toString(),
            longitude: e.lon.toString(),
          ),
        );
      }
    }

    updateLoadingNearby(false);
  }
}
