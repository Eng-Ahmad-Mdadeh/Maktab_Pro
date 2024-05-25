import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<Position?> getCurrentLocation() async {
    LocationPermission permission;

    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // print(serviceEnabled);
    // if (!serviceEnabled) {
    //   return null;
    // }
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      // if (permission == LocationPermission.deniedForever) {
      //   return Future.error(
      //       'Location permissions are permanently denied, we cannot request permissions.');
      // }

      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        return await Geolocator.getCurrentPosition();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
