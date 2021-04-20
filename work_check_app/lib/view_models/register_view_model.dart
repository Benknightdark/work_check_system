import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_check_app/models/register.dart';
import 'package:work_check_app/services/base_service.dart';

class RegisterViewModel extends ChangeNotifier {
  Register register = Register();
  //notifyListeners();
  Future<Response<dynamic>?> registerUser() async {
    try {
      var data =
          await customDio().post('/account/register', data: register.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // print(data.data['data']['access_token']);
      await prefs.setString('token', data.data['data']['access_token']);
      notifyListeners();
      return data;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
