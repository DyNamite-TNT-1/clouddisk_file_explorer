//header của login
import 'package:clouddisk_login_form/models/user.dart';

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
};
List<String> cookie = [
  ";HANBIRO_GW=${user.session}",
  "hmail_key=${user.hmailKey}",
  "cook=kie",
];

//header của getFolder, sortFolder
final fileHeader = {
  "Cookie": cookie.join(";"),
};
