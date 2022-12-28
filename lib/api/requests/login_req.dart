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
  "oRfAa0Ex1ZVsHLimNx5XpV1eeiNs+g2OhPIDYHI8IpWFhHNQ2Nm0C1KuISROSJj9NZ6rpnL6ZsYduCKvD38he8bfK7lQHB/3EcDEZWRUgCyv4z61OAf2pMXhQfbOWvCMfsdJ0JBun7iC1mQ7aSLzT/JJYDUybwJbPx72GOjQ1j4=",
  "wtsaWk7utF6GtHIFZKwXYarexC/Qp4fY/5xAjq7+gC/afF1d1/Gt7FEgU1UcnHxLtNHOn2dgC8Z7qdTMonGaZ+aRTGWh70sfxy0QLL7Ij/RyjqqIwqGuxNXrSOkwcp3EiN1S/6z7maMTl5XZ6c/Bww3w/G1mcsmnPCZ6gaJzMMk=",
  "samsung SM-N970F",
  "212970",
  "2eaba74b-e0b5-49cb-b9ab-f9630845d43b",
);
