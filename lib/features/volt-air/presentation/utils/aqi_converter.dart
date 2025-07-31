import 'dart:math';

class AQICalculator {
  double pm25, pm10, co, so2, no2;

  AQICalculator({
    required this.pm25,
    required this.pm10,
    required this.co,
    required this.so2,
    required this.no2,
  });

  double calculateAQI(
      double C, List<double> breakpoints, List<double> aqiValues) {
    for (int i = 0; i < breakpoints.length - 1; i++) {
      if (C <= breakpoints[i + 1]) {
        return ((aqiValues[i + 1] - aqiValues[i]) /
                    (breakpoints[i + 1] - breakpoints[i])) *
                (C - breakpoints[i]) +
            aqiValues[i];
      }
    }
    return -1;
  }

  double calculatePM25AQI() {
    return calculateAQI(pm25, [0, 12, 35.4, 55.4, 150.4, 250.4, 500.4],
        [0, 50, 100, 150, 200, 300, 500]);
  }

  double calculatePM10AQI() {
    return calculateAQI(pm10, [0, 54, 154, 254, 354, 424, 604],
        [0, 50, 100, 150, 200, 300, 500]);
  }

  double calculateCOAQI() {
    double co_ppm = co / 1145.0; // Conversion from µg/m³ to ppm
    return calculateAQI(co_ppm, [0, 4.4, 9.4, 12.4, 15.4, 30.4, 50.4],
        [0, 50, 100, 150, 200, 300, 500]);
  }

  double calculateSO2AQI() {
    double so2_ppb = so2 / 2.62; // Conversion from µg/m³ to ppb
    return calculateAQI(so2_ppb, [0, 35, 75, 185, 304, 604, 804],
        [0, 50, 100, 150, 200, 300, 500]);
  }

  double calculateNO2AQI() {
    double no2_ppb = no2 / 1.88; // Conversion from µg/m³ to ppb
    return calculateAQI(no2_ppb, [0, 53, 100, 360, 649, 1249, 1649],
        [0, 50, 100, 150, 200, 300, 500]);
  }

  double calculateOverallAQI() {
    double pm25AQI = calculatePM25AQI();
    double pm10AQI = calculatePM10AQI();
    double coAQI = calculateCOAQI();
    double so2AQI = calculateSO2AQI();
    double no2AQI = calculateNO2AQI();

    var index = max(max(max(pm25AQI, pm10AQI), max(coAQI, so2AQI)), no2AQI);

    return index > 120 ? index / 2 : index;
  }

  String getAQICategory(double aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }
}
