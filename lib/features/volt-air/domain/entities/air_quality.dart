class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });
}

class MainData {
  final int aqi;

  MainData({
    required this.aqi,
  });
}

class Components {
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;

  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });
}

class AirQuality {
  final MainData main;
  final Components components;
  final int dt;

  AirQuality({
    required this.main,
    required this.components,
    required this.dt,
  });
}

class AirQualityResponse {
  final Coord coord;
  final List<AirQuality> list;

  AirQualityResponse({
    required this.coord,
    required this.list,
  });
}
