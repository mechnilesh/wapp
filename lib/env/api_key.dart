import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../shared/app_constants.dart';

class ApiKey {
  static final ApiKey _instance = ApiKey._internal();

  factory ApiKey() {
    return _instance;
  }

  ApiKey._internal();

  Future loadApiKey() async {
    String key = '';
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      log(e.toString());
    }
    key = dotenv.env['APP_ID'] ?? '';
    AppConstants.setAppId(key);
  }
}
