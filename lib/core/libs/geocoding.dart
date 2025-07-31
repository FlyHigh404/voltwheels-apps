import 'dart:async';
import 'package:geocoding/geocoding.dart';

Future<String?> getAddressFromLatLng(double latitude, double longitude,
    {bool returnSubLocality = false}) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      if (returnSubLocality) {
        String? subLocality = place.subLocality;

        if (subLocality != '') {
          return subLocality;
        } else {
          return null;
        }
      }

      return "${place.subLocality}, ${place.subAdministrativeArea}";
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
