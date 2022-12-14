class LogInResponse {
  late bool success;
  late final String? msg;
  late String session;
  late String hmailkey;
  LogInResponse(Map map) {
    success = map["success"];
    msg = map["msg"];
    session = map["session"];
    hmailkey = map["hmail_key"];
  }

  Map getMap() {
    return {
      "success": success,
      "msg": msg,
      "session": session,
      "hmail_key": hmailkey,
    };
  }
}
