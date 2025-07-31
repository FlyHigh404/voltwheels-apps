import 'dart:math';

import 'package:geolocator/geolocator.dart';

class GeolocatorLib {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }
}

class CustomPosition {
  final double lat;
  final double lon;

  const CustomPosition({
    required this.lat,
    required this.lon,
  });

  @override
  String toString() {
    return 'CustomPosition(lat: $lat, lon: $lon)';
  }
}

List<CustomPosition> getNearbyCoordinates(
  Position position,
  int count,
  double radiusInMeters, {
  double accuracy = 10.0,
}) {
  print("Generating nearby locations...");

  final random = Random();
  final radiusInDegrees =
      radiusInMeters / 111320.0; // Approximate meters to degrees
  final accuracyInDegrees = accuracy / 111320.0;

  List<CustomPosition> nearbyCoordinates = [];

  for (int i = 0; i < count; i++) {
    double newLat = position.latitude;
    double newLng = position.longitude;
    bool foundUniqueCoordinate = false;

    while (!foundUniqueCoordinate) {
      final distance = radiusInDegrees *
          (random.nextDouble() * (1 - accuracyInDegrees / radiusInDegrees) +
              accuracyInDegrees / radiusInDegrees);
      final angle = 2 * pi * random.nextDouble();

      final deltaLat = distance * cos(angle);
      final deltaLng =
          distance * sin(angle) / cos(position.latitude * pi / 180.0);

      newLat = position.latitude + deltaLat;
      newLng = position.longitude + deltaLng;

      if (newLat < -90 || newLat > 90 || newLng < -180 || newLng > 180) {
        continue;
      }

      foundUniqueCoordinate = true;
      for (var coord in nearbyCoordinates) {
        final distanceToExisting = _haversineDistance(
          newLat,
          newLng,
          coord.lat,
          coord.lon,
        );
        if (distanceToExisting < accuracy) {
          foundUniqueCoordinate = false;
          break;
        }
      }
    }

    nearbyCoordinates.add(
      CustomPosition(
        lat: newLat,
        lon: newLng,
      ),
    );
  }

  return nearbyCoordinates;
}

// Haversine distance calculation function
double _haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371000; // Earth radius in meters
  final double dLat = (lat2 - lat1) * pi / 180.0;
  final double dLon = (lon2 - lon1) * pi / 180.0;

  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180.0) *
          cos(lat2 * pi / 180.0) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}
