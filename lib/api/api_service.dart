import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio = Dio();
  Future<String> get(url, Map<String, dynamic>? header) async {
    var response = await _dio.get(
      url,
      options: Options(
        headers: header,
      ),
    );
    var responseData = response.data;
    return responseData;
  }

  Future<Map> post(url, Map req, Map<String, dynamic>? header) async {
    var response = await _dio.post(
      url,
      data: req,
      options: Options(
        headers: header,
      ),
    );
    var responseData = response.data;

    return responseData;
  }
}
