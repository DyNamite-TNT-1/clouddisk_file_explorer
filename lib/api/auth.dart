// ignore: depend_on_referenced_packages
import 'package:clouddisk_login_form/models/user.dart';
import 'package:dio/dio.dart';

const baseUrl = "https://groupware57.hanbiro.net";
const loginUrl = "$baseUrl/ngw/sign/auth?is_checking_otp=1";
const getFolderUrl = "$baseUrl/cloud/api/get.php?access=1&type=dir";
//header của login
final loginHeader = {
  "Content-Type": "application/x-www-form-urlencoded",
  'APP_TYPE': 'clouddisk',
  'App-Type': 'clouddisk',
  'app-type': 'clouddisk',
  'DEVICE_TYPE': 'android',
  'device-type': 'android',
  'Device-Type': 'android',
  'DEVICE': 'phone',
  'device': 'phone',
  'device_id': '1e10f743-196e-4bc0-aee7-8c14690f2ac4',
  'X-REQUESTED-WITH': 'XMLHttpRequest',
  "User_Agent": "Android 1.66 APP_HANBIRO_2.0.0.2",
  "Cookie":
      ";HANBIRO_GW=010254fedc4eaa12683367c2601053f919d8fd28b35cfd8c2f42173ed918e48eb9ab17480894076ec3ad7e268176e6b3;hmail_key=33b0cd76a231a3a0a6e247d814c23f9a;cook=kie",
};
List<String> cookie = [
  ";HANBIRO_GW=${user.session}",
  "hmail_key=${user.hmailKey}",
  "cook=kie",
];

//header của getFolder
final folderHeader = {
  "Cookie": cookie.join(";"),
};

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

Future getFolderlv2() async {
  AuthApi api = AuthApi();

  String url =
      "https://groupware57.hanbiro.net/cloud/api/get.php?cache=false&id=my&type=file";
  var resp = await api.get(url, folderHeader);
  // ignore: unnecessary_type_check
  print(resp);
}
