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
    String listToString = "[";
    for (var element in files) {
      if (files.indexOf(element) == files.length - 1) {
        listToString +=
            "{\"id\":\"${element["id"]}\",\"name\":\"${element["name"]}\",\"count\":\"${element["count"]}\",\"expire\":\"${element["expire"]}\"}";
      } else {
        listToString +=
            "{\"id\":\"${element["id"]}\",\"name\":\"${element["name"]}\",\"count\":\"${element["count"]}\",\"expire\":\"${element["expire"]}\"},";
      }
    }
    return "$listToString]";
  }
}
