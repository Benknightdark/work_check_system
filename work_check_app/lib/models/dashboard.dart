class Dashboard {
  String displayName = '';
  int workHour = 0;
  String punchInTime = '';
  String punchOutTime = '';
  Dashboard(
      {this.displayName, this.workHour, this.punchInTime, this.punchOutTime});
  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
        displayName: json["displayName"],
        workHour: json['workHour'],
        punchInTime: json['punchInTime'],
        punchOutTime: json['punchOutTime']);
  }
}
