import 'dart:convert';

import 'package:clouddisk_login_form/models/login.dart';
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

const Map<String, String> data = {
  "token":
      "cmGw7OXyYe4:APA91bGYAL29_GyI7wx3IcFiVYsxZbt8FtJJezhs1Ot_F0F1vEHljzkmV28p9owvsI3ABM3yvqwpkEdqCXJWTGwXb9XQwFtDYqaS-9Inc",
  "gw_id":
      "oRfAa0Ex1ZVsHLimNx5XpV1eeiNs+g2OhPIDYHI8IpWFhHNQ2Nm0C1KuISROSJj9NZ6rpnL6ZsYduCKvD38he8bfK7lQHB/3EcDEZWRUgCyv4z61OAf2pMXhQfbOWvCMfsdJ0JBun7iC1mQ7aSLzT/JJYDUybwJbPx72GOjQ1j4=",
  "gw_pass":
      "wtsaWk7utF6GtHIFZKwXYarexC/Qp4fY/5xAjq7+gC/afF1d1/Gt7FEgU1UcnHxLtNHOn2dgC8Z7qdTMonGaZ+aRTGWh70sfxy0QLL7Ij/RyjqqIwqGuxNXrSOkwcp3EiN1S/6z7maMTl5XZ6c/Bww3w/G1mcsmnPCZ6gaJzMMk=",
  "model": "samsung SM-N970F",
  "code": "212970",
  "device_id": "2eaba74b-e0b5-49cb-b9ab-f9630845d43b",
};

class AuthApi {
  final Dio _dio = Dio();
  Future<LogInResponse> logInApi(LogInRequest? req) async {
    try {
      var response = await _dio.post(
        baseUrl,
        data: data,
        options: Options(
          headers: defaultHeader,
        ),
      );
      var responseData = response.data;
      return LogInResponse(
        success: responseData["success"],
      );
    } catch (e) {
      print(e);
      return LogInResponse(
        success: false,
        messageError: e.toString(),
      );
    }
  }
}
