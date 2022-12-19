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
  // "Cookie":
  //     ";HANBIRO_GW=010254fedc4eaa12683367c2601053f919d8fd28b35cfd8c2f42173ed918e48eb9ab17480894076ec3ad7e268176e6b3;hmail_key=33b0cd76a231a3a0a6e247d814c23f9a;cook=kie",
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
