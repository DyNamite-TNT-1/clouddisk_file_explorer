import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:clouddisk_login_form/utils/preferences.dart';

UserPreferences prefs = UserPreferences();
Api api = Api();

List<Map<String, dynamic>> listMapChecked = [];
bool isSort = false;
bool isClickedSort = false;
bool isClickedDefault = false;
String sortType = "size";
String order = "asc";
String currentId = "";
String preId = "";
