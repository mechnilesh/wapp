

import '../data/api_endpoints.dart';
import '../data/network/network_api_service.dart';

class WeatherRepository {
  final NetworkApiService _baseApiServices = NetworkApiService();

  Future<dynamic> getWeather(Map<String, dynamic> parameter) async {
    try {
      dynamic response =
          _baseApiServices.getGetApiResponse(ApiEndPoint.data, parameter);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
