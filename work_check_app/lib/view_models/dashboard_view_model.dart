import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:work_check_app/models/dashboard.dart';
import 'package:work_check_app/models/punch.dart';
import 'package:work_check_app/services/api/punchservice.dart';
import 'package:work_check_app/services/base_service.dart';
import 'package:work_check_app/services/device/geo_code_service.dart';

class DashboardViewModel extends ChangeNotifier {
  Dashboard dashboard = Dashboard();
  // 取得Dashboard資料
  Future<void> fetchDashboard() async {
    // final results = await Webservice().fetchMovies(keyword);
    // this.movies = results.map((item) => MovieViewModel(movie: item)).toList();
    //print(this.movies);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dd = prefs.getString("token");
    if (dd == null) {
      this.dashboard.displayName = '登入';
      this.dashboard.workHour = 0;
    } else {
      var data = await customAuthDio().get('/account/me');
      if (data.data['title'] != "200") {
        this.dashboard.displayName = '登入';
        this.dashboard.workHour = 0;
      } else {
        this.dashboard.displayName = data.data['data']['displayName'];
        this.dashboard.workHour = 5487;
      }
    }
    EasyLoading.dismiss();
    notifyListeners();
    return;
  }

  // 打卡
  Future<dynamic> punch(String punchType) async {
    //try {
    var userData = await customAuthDio().get('/account/me');
    if (userData.data["title"] != '200') {
      return userData.data;
    }
    var model = new Punch();
    // model.ID = Uuid().v4();
    // print(punchType);
    model.punchType = punchType;
    final positionData = await determinePosition();
    // print(positionData.longitude);
    // print(positionData.latitude);
    model.latitude = positionData.latitude.toString();
    model.longtitude = positionData.longitude.toString();

    model.punchDateTime =
        new DateFormat("yyyy/MM/dd HH:mm:ss").format(new DateTime.now());
    var wifiBSSID = await WifiInfo().getWifiBSSID();
    var wifiIP = await WifiInfo().getWifiIP();
    var wifiName = await WifiInfo().getWifiName();

    // print(wifiBSSID);
    // print(wifiIP);
    // print(wifiName);
    model.wifiBSSId = wifiBSSID == null ? "" : wifiBSSID;
    model.wifiIP = wifiIP;
    model.wifiName = wifiName == null ? "" : wifiName;
    model.userId = userData.data['data']["userId"];
    var p = new Punchservice();
    var res = await p.postPunc(model.toMap());
    // print(res);
    notifyListeners();
    if (res == null) {
      return null;
    }
    return res.data;
  }
}
