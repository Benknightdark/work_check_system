import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://e1885ecdbfc5.ngrok.io/api";
// 一般呼叫api
Dio customDio() {
  BaseOptions options = new BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );
  Dio dio = new Dio(options);
  dio.interceptors.add(InterceptorsWrapper(onResponse:
      (Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
    //return response; // continue
  }, onError: (DioError e, ErrorInterceptorHandler handler) async {
    handler.next(e);
    print(e.response);
    EasyLoading.showError(e.response?.data['data']['detail']);
    // return e.response;
  }));
  return dio;
}

// 加入jwt token呼叫api
Dio customAuthDio() {
  Dio dio = customDio();
  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    dio.interceptors.requestLock.lock();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    token = token == null ? "" : token;
    options.headers["Authorization"] = "Bearer " + token;
    dio.interceptors.requestLock.unlock();
    handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);

    // continue
  }, onError: (DioError e, ErrorInterceptorHandler handler) async {
    handler.next(e);
    print(e.response);
    EasyLoading.showError(e.response?.data['data']['detail']);
  }));

  return dio;
}
