class LogInRequest {
  // final String domain;
  // final String id;
  // final String password;
  // LogInRequest(this.domain, this.id, this.password);
}

class LogInResponse {
  bool success;
  String? messageError;

  LogInResponse({
    required this.success,
    this.messageError,
  });
}
