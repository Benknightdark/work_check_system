import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://54739717e384.ngrok.io/api";
// 一般呼叫api
Dio customDio() {
  BaseOptions options = new BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );
  Dio dio = new Dio(options);
  dio.interceptors
      .add(InterceptorsWrapper(onResponse: (Response response) async {
    return response; // continue
  }, onError: (DioError e) async {
    print(e.response);
    EasyLoading.showError(e.response.data['data']['detail']);
    return e.response;
  }));
  return dio;
}

// 加入jwt token呼叫api
Dio customAuthDio() {
  Dio dio = customDio();
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    dio.interceptors.requestLock.lock();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    token = token == null ? "" : token;
    options.headers["Authorization"] = "Bearer " + token;
    dio.interceptors.requestLock.unlock();
    return options;
  }, onResponse: (Response response) async {
    return response; // continue
  }, onError: (DioError e) async {
    // if (e.response.data["title"] == "422") {
    //   EasyLoading.showError("傳送資料未符合欄位驗證規則");
    // } else {
    //   EasyLoading.showError(e.response.data['data']['detail']);
    // }
    return e.response;
  }));

  return dio;
}
