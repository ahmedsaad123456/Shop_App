import 'package:dio/dio.dart';

//==========================================================================================================================================================

class DioHelper {
  static Dio dio = Dio();

//==========================================================================================================================================================

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          ),
    );
  }

  //==========================================================================================================================================================

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers=
      {
        'lang' :lang,
        'Authorization' : token??'',
        'Content-Type': 'application/json'

      };
    
    return await dio.get(url, queryParameters: query);
  }

  //==========================================================================================================================================================

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  })async {
    dio.options.headers=
      {
        'lang' :lang,
        'Authorization' : token??'',
        'Content-Type': 'application/json'

      };
    
      
    
    return dio.post(url, queryParameters: query, data: data);
  }

//================================================================================================================================

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  })async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

//================================================================================================================================

  
}

//================================================================================================================================





// url : https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// baseUrl : https://newsapi.org/
// method : v2/top-headlines?
// queryParameters : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca