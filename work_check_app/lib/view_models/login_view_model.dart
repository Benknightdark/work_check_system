import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_check_app/models/login.dart';
import 'package:work_check_app/services/base_service.dart';

class LoginViewModel extends ChangeNotifier {
  Login loginModel = Login();
  Future<bool> login() async {
    try {
      var data =
          await customDio().post('/account/login', data: loginModel.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (data.data['title'] == "200") {
        notifyListeners();
        await prefs.setString('token', data.data['data']['access_token']);
        return true;
      }
      return false;
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }
}
