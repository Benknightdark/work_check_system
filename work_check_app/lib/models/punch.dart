class Punch {
  String punchType = '';
  String punchDateTime = '';
  String userId = '';
  String latitude = '';
  String longtitude = '';
  String wifiBSSId = '';
  String wifiIP = '';
  String wifiName = '';

  Punch(
      {this.punchType,
      this.punchDateTime,
      this.userId,
      this.latitude,
      this.longtitude,
      this.wifiBSSId,
      this.wifiIP,
      this.wifiName});
  Map<String, dynamic> toMap() {
    return {
      "punchType": punchType,
      "punchDateTime": punchDateTime,
      "userId": userId,
      "latitude": latitude,
      "longtitude": longtitude,
      "wifiBSSId": wifiBSSId,
      "wifiIP": wifiIP,
      "wifiName": wifiName,
    };
  }
}
