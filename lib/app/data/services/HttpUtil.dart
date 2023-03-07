import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../../theme/values/Values.dart';

/// @Author Airsado
/// @Date 2023-09-11 17:33
/// @Version 1.0
/// @Description Dio网络请求封装
class HttpUtil {
  Dio? dio;
  late final CookieJar _cookieJar = CookieJar();

  //共享Cookie
  List<Cookie>? _cookie;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    final BaseOptions options = BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        headers: AppConstant.baseHeaders,
        followRedirects: true);
    dio = Dio(options);
    //Cookie管理
    dio?.interceptors.add(CookieManager(_cookieJar));
    //dio 拦截器
    dio?.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // 在发送请求前打印请求信息
        // print('Request: ${options.method} ${options.uri}');
        // print('Headers: ${options.headers}');
        // print('Cookies: ${options.headers['cookie']}'); // 打印请求头中的 cookie
        // print('Data: ${options.data}'); // 打印请求数据

        handler.next(options); // 继续请求
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // 在接收到响应后打印响应信息
        // print('Response: ${response.statusCode}');
        // print('Response Data: ${response.data}');

        handler.next(response); // 继续处理响应
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        // 在请求出错时打印错误信息
        // print('Request Error: ${e.message}');
        // if (e.response != null) {
        //   print('Response Data: ${e.response!.data}');
        // }

        handler.next(e); // 继续处理错误
      },
    ));
  }

  ///  dio获取内容
  Future get(String path,
      {Map<String, dynamic>? queryParameters,
      Object? data,
      Options? options}) async {
    Response response = await dio!.get(path,
        queryParameters: queryParameters, data: data, options: options);
    return response;
  }

  ///  dio提交内容
  Future post(String path,
      {Map<String, dynamic>? queryParameters,
      Object? data,
      Options? options}) async {
    Response response = await dio!.post(path,
        queryParameters: queryParameters, data: data, options: options);
    _cookie = await _cookieJar.loadForRequest(Uri.parse(AppConstant.baseUrl));
    return response;
  }

  ///  获取指定url当前的cookie
  List<Cookie>? get cookie => _cookie;
}
