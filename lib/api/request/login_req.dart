class LogInRequest {
  final String gwid;
  final String gwpass;
  final String model;
  final String code;
  final String deviceid;
  LogInRequest(this.gwid, this.gwpass, this.model, this.code, this.deviceid);

  Map getMap() {
    return {
      'gw_id': gwid,
      'gw_pass': gwpass,
      'model': model,
      'code': code,
      'device_id': deviceid
    };
  }
}

final LogInRequest logInRequest = LogInRequest(
  "jai1nXEjw8N7Akxof9UYIfp6hW5YFmlO2cGKkLlFr3zxC+mr8q6ZRXWhUysoSQkYqJXD7eFpg9ypOeREIDrHdbgyA6eIUvo6yhPN4K2FuWIkL+xQQGTCvZmXisxeJXkfmJO1i6VJ47aBZMooPoWEdMJag3/RqqXqY+iiECx8RLk=",
  "Kp6mUKz3HFav6GaceGbXz0Yb+5cg68SavnTP/avUEv2O2SmJ04mG1/9LcZKT8G19XQ9zGzOwYl7gd/ID408lDfx/MLSvYhPuZV+X9C4Da16Dk1q16MEG22GjjutWKqSYAkXBz1ftQhGuWtEUMOHu0XklnrDQYWEAqA8nOsK+gv4=",
  "samsung SM-N970F",
  "212970",
  "2eaba74b-e0b5-49cb-b9ab-f9630845d43b",
);
