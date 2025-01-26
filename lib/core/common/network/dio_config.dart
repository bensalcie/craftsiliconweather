import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';

@lazySingleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json'};
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: false,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false,
      ));
    }
  }
  Future get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      final newEntries = {
        'appid': dotenv.env['WEATHER_API_KEY'],
      };
      queryParameters?.addEntries(newEntries.entries);
      //Check if any query parameters are passed
      if (queryParameters != null) {
        queryParameters.forEach((key, value) {
          if (value != null && value != '') {
            queryParameters[key] = value;
          }
        });
      }

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        data: queryParameters,
        // options: Options(headers: {'Authorization': appToken}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }

  Future<int?> checkInternetConenctivity(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              //String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              //return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        data: queryParameters,
        // options: Options(headers: {'Authorization': appToken}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.statusCode;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data.');
    } catch (e) {
      throw ServerException();
    }
  }
}
