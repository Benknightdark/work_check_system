import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_check_app/services/api/punchservice.dart';
import 'package:work_check_app/services/base_service.dart';

class PunchlistViewModel extends ChangeNotifier {
  List<dynamic> punchlist = List<dynamic>();
  bool showCalendar = false;
  void changeDisplay() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  Future<void> fetchPunchList() async {
    var userData = await customAuthDio().get('/account/me');
    if (userData.data["title"] != '200') {
      EasyLoading.showToast(userData.data['data']['detail']);
    } else {
      var p = new Punchservice();
      var res = await p.getPunchList(userData.data['data']['userId']);
      this.punchlist = res.data['data'];
      // print(this.punchlist);
    }
    notifyListeners();
  }
}
