// ignore: depend_on_referenced_packages
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/models/user.dart';
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

// Future getFolderlv2() async {
//   AuthApi api = AuthApi();

//   String url = getFolderUrl("file", "my");
//   var resp = await api.get(url, folderHeader);
//   // ignore: unnecessary_type_check
//   print(resp);
// }
