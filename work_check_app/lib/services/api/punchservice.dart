import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../base_service.dart';

class Punchservice {
  Future<Response<dynamic>?> postPunc(dynamic punch) async {
    try {
      var data = await customAuthDio().post('/punch', data: punch);
      return data;
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
      return null;
    }
  }

  Future<Response<dynamic>?> getPunchList(String userId) async {
    var data = await customAuthDio().get('/punch/' + userId);
    return data;
  }
}
