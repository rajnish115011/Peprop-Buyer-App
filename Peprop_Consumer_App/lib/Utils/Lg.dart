import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Lg{
  Future<String> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      // await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return GetAddressFromLatLong(await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high));
  }
  Future<String> GetAddressFromLatLong(Position position)async {
    String aaddress="";
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    aaddress = ' ${place.locality}';
    return aaddress;
  }


}