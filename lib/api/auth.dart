import 'package:dio/dio.dart';

const baseUrl =
    'https://groupware57.hanbiro.net/ngw/sign/auth?is_checking_otp=1';
const defaultHeader = {
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
};

class AuthApi {
  final Dio _dio = Dio();

  Future<Map> post(url, Map req) async {
    var response = await _dio.post(
      url,
      data: req,
      options: Options(
        headers: defaultHeader,
      ),
    );
    var responseData = response.data;
    return responseData;
  }
}
