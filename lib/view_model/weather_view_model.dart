import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wapp/utils/utils.dart';

import '../data/response/api_response.dart';
import '../model/weather_model.dart';
import '../repositories/weather_repository.dart';
import '../services/location_service.dart';
import '../shared/app_constants.dart';
import '../utils/enums.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repo = WeatherRepository();
  String locationName = '';

  Future<String?> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[2];
        locationName = placemark.name.toString();

        notifyListeners();
        return placemark
            .name; // You can use other fields like `placemark.thoroughfare` or `placemark.locality` for different address details.
      }
      return 'Location not found';
    } catch (e) {
      return 'Error: $e';
    }
  }

  ApiResponse<WeatherModel> _response = ApiResponse.loading();

  ApiResponse<WeatherModel> get response => _response;

  setStatus(ApiResponse<WeatherModel> status) {
    _response = status;
    notifyListeners();
  }

  Future getWeather(BuildContext context) async {
    setStatus(ApiResponse.loading());

    Position latLang = await determinePosition();
    notifyListeners();

    Map<String, dynamic> params = {
      "lat": latLang.latitude.toString(),
      'lon': latLang.longitude.toString(),
      'lang': AppConstants.lang,
      'units': AppConstants.units,
    };

    await getLocationName(latLang.latitude, latLang.longitude);

    // print("praams: $params");
    await _repo.getWeather(params).then((value) {
      log(value.toString());
      WeatherModel model = WeatherModel.fromJson(value);
      // _sp.saveString(AppConstants.weatherData, weatherModelToJson(model));
      setStatus(ApiResponse.completed(model));
    }).catchError((e) {
      setStatus(ApiResponse.error(e.toString()));
      context.snowSnackBar(e.toString(),
          type: SnackBarTypeEnum.error, milliseconds: 2000);
    });

    notifyListeners();
  }

  Future refresh(BuildContext context) async {
    await getWeather(context);
  }

  localOrApiData(BuildContext context) async {
    setStatus(ApiResponse.loading());

    await getWeather(context);
  }
}
