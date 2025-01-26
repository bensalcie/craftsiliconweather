import 'package:dio/dio.dart';

class NetworkUtils {
  /// Constructor to initialize Dio instance
  NetworkUtils();

  /// Checks if internet is available by making an HTTP request.
  /// [testUrl] defaults to "https://www.google.com".
  /// Timeout is set to 5 seconds to prevent long delays.
  Future<bool> isInternetAvailable(
      {String testUrl = "https://www.google.com"}) async {
    try {
      final response = await Dio()
          .get(
            testUrl,
            options: Options(
              responseType: ResponseType.plain,
              followRedirects: false,
              validateStatus: (status) => status != null && status < 500,
            ),
          )
          .timeout(const Duration(seconds: 5));

      // If response status code is OK (200), internet is available
      return response.statusCode == 200;
    } catch (e) {
      // If any error occurs (timeout, no connection, etc.), return false
      return false;
    }
  }
}
