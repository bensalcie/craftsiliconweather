import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModules {
  // ignore: invalid_annotation_target
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // Register the baseUrl String.
  @Named('BaseUrl')
  String get baseUrl => dotenv.env['BASE_URL']!;

  // Register the method channel for communication with platform code. Incase there will be any.

  @singleton
  MethodChannel get channel => const MethodChannel(app_package_name);

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));
}
