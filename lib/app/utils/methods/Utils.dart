import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';

/// @Author Airsado
/// @Date 2023-09-20 22:20
/// @Version 1.0
/// @Description 字符转换、时间转换之类的

class Utils {
  //GBK编码转UTF-8编码
  String gbkToUtf8(Response response) {
    List<int> responseBytes = response.data;
    return gbk.decode(responseBytes);
  }
}
