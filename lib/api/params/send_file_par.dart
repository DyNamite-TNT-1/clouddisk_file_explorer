import 'dart:convert';

class SendFile {
  List<Map<String, dynamic>> files;
  String mode;
  SendFile(this.files, this.mode);
  Map getMap() {
    return {
      "files": files,
      "mode": mode,
    };
  }

  String convertListToString() {
    return jsonEncode(files);
  }
}
