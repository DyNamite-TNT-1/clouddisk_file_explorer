class SendFileResponse {
  late bool success;
  late List<dynamic> data;
  SendFileResponse(Map map) {
    success = map["success"];
    data = map["data"];
  }

  @override
  String toString() {
    return "success: $success, data: ${data.toString()}";
  }
}
