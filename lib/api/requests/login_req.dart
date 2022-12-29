class LogInRequest {
  String gwid;
  String gwpass;
  String model;
  String code;
  String deviceid;
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
  "aZcd4/kTCtwy43oLBv/XZauLTqncqSl3GaNCee5+OKDmz6ItmyIX9Gf3dMftuhfYfRJDrlj8pd4YrRpAQ0EGqc81PbE9tFYy+U7dqUHmcwcS26rZw334yM7T/pskp9YVPwZwd2T5OpVSHqiGEBB9NbLD1MwPeeGgyQ7FPVRqn5U=",
  "fK2i43LlgZ2X2/O5pl8tTudt5YPlvXRvS3ax/rU+Xa+8TNitrRifTYKUs7GEZsU4ATOeVhy3rCzJ4T8/jmGsfXgDGS1E4d9U3dnV5QM34lAzjzpJlo87nsGHUJjA9Yvjtpw42RihXk+y7RVtpcgCKwkBQ2mjP0fxuUVTYJvQv8I=",
  "",
  "",
  "",
);
