
import '../../domain/entities/air_quality.dart';

class CoordModel extends Coord {
  CoordModel({
    required super.lon,
    required super.lat,
  });

  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}


class MainDataModel extends MainData {
  MainDataModel({
    required super.aqi,
  });

  factory MainDataModel.fromJson(Map<String, dynamic> json) {
    return MainDataModel(
      aqi: json['aqi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aqi': aqi,
    };
  }
}


class ComponentsModel extends Components {
  ComponentsModel({
    required super.co,
    required super.no,
    required super.no2,
    required super.o3,
    required super.so2,
    required super.pm2_5,
    required super.pm10,
    required super.nh3,
  });

  factory ComponentsModel.fromJson(Map<String, dynamic> json) {
    return ComponentsModel(
      co: json['co'].toDouble(),
      no: json['no'].toDouble(),
      no2: json['no2'].toDouble(),
      o3: json['o3'].toDouble(),
      so2: json['so2'].toDouble(),
      pm2_5: json['pm2_5'].toDouble(),
      pm10: json['pm10'].toDouble(),
      nh3: json['nh3'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'co': co,
      'no': no,
      'no2': no2,
      'o3': o3,
      'so2': so2,
      'pm2_5': pm2_5,
      'pm10': pm10,
      'nh3': nh3,
    };
  }
}


class AirQualityModel extends AirQuality {
  AirQualityModel({
    required MainDataModel super.main,
    required ComponentsModel super.components,
    required super.dt,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    return AirQualityModel(
      main: MainDataModel.fromJson(json['main']),
      components: ComponentsModel.fromJson(json['components']),
      dt: json['dt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': (main as MainDataModel).toJson(),
      'components': (components as ComponentsModel).toJson(),
      'dt': dt,
    };
  }
}

class AirQualityResponseModel extends AirQualityResponse {
  AirQualityResponseModel({
    required CoordModel coord,
    required List<AirQualityModel> list,
  }) : super(
    coord: coord,
    list: list,
  );

  factory AirQualityResponseModel.fromJson(Map<String, dynamic> json) {
    var listJson = json['list'] as List;
    List<AirQualityModel> airQualityList =
    listJson.map((i) => AirQualityModel.fromJson(i)).toList();

    return AirQualityResponseModel(
      coord: CoordModel.fromJson(json['coord']),
      list: airQualityList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': (coord as CoordModel).toJson(),
      'list': list.map((e) => (e as AirQualityModel).toJson()).toList(),
    };
  }
}
