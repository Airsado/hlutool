import 'dart:io';
import 'dart:math';

import 'package:hlutool/app/utils/methods/Log.dart';

/// @Author Airsado
/// @Date 2023-10-04 15:19
/// @Version 1.0
/// @Description Windows平台外部命令执行netsh

class NetshUtils {
  //添加网络配置文件
  Future<void> addWlanXml(
      {Function? success, Function? fail, Function? error}) async {
    String wlan1 =
        Platform.resolvedExecutable.replaceAll("hlutool.exe", "stu-wifi.xml");
    // String wlan2 =
    //     Platform.resolvedExecutable.replaceAll("hlutool.exe", "hlu-stu.xml");

    try {
      ProcessResult result1 = await Process.run(
          'netsh', // Windows上的命令行工具
          ['wlan', 'add', 'profile', 'filename=$wlan1']);

      // final result2 = await Process.run(
      //     'netsh', // Windows上的命令行工具
      //     ['wlan', 'add', 'profile', 'filename=$wlan2']);

      if (result1.exitCode == 0) {
        Log.i('WiFi configuration successful.${result1.stdout}');

        success;
      } else {
        Log.d("添加Wlan配置文件失败：${result1.stderr}");
        fail;
      }
    } catch (e) {
      Log.e("Netsh Add报错如下：", e as StackTrace);
      error;
    }
  }

  //获取Wlan配置文件列表
  Future<String> showProfile() async {
    ProcessResult result = await Process.run(
        'netsh', // Windows上的命令行工具
        ['wlan', 'show', 'profile']);
    return result.stdout.toString();
  }
}
