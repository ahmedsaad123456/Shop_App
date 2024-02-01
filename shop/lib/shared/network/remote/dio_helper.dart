import 'package:dio/dio.dart';

//==========================================================================================================================================================

// A helper class for making HTTP requests using Dio
class DioHelper {
  // Singleton instance of Dio
  static Dio dio = Dio();

//==========================================================================================================================================================

  // Method to initialize Dio with base options
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  //==========================================================================================================================================================

  // Method to make a GET request
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    // Set headers for the request
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    // Send the GET request
    return await dio.get(url, queryParameters: query);
  }

  //==========================================================================================================================================================

  // Method to make a POST request
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    // Set headers for the request
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    // Send the POST request
    return dio.post(url, queryParameters: query, data: data);
  }

//================================================================================================================================

  // Method to make a PUT request
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    // Set headers for the request
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    // Send the PUT request
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

//================================================================================================================================

  
}

//================================================================================================================================
