import 'dart:io';

import 'package:hlutool/app/utils/methods/LocalStore.dart';
import 'package:hlutool/app/utils/methods/Utils.dart';
import 'package:intranet_ip/intranet_ip.dart';
import 'package:dio/dio.dart';
import 'package:hlutool/app/data/services/HttpUtil.dart';
import 'package:hlutool/app/theme/values/Values.dart';
import 'package:hlutool/app/utils/methods/Log.dart';

import '../../enmu/AccountStatus.dart';

/// @Author Airsado
/// @Date 2023-09-12 22:02
/// @Version 1.0
/// @Description 校园网相关请求
class CampusNetwork {
  static final CampusNetwork _instance = CampusNetwork._internal();

  factory CampusNetwork() => _instance;

  CampusNetwork._internal();

  ///  校园网认证请求
  void authentication(String user, String password) async {
    InternetAddress ip = await intranetIpv4();
    Log.d("正在认证校园网：认证用户（$user）,认证IP（${ip.address}）");
    await HttpUtil()
        .post(AppConstant.authUrl,
            data: {
              'action': 'login',
              'user': user,
              'pwd': password,
              'usrmac': 'cc:cc:81:3f:0a:41',
              'ip': ip.address,
              'success':
                  '${AppConstant.baseHeaders}libs/portal/unify/portal.php/login/success/nastype/Panabit/basip/10.99.99.99/usrip/${ip.address}',
              'fail':
                  '${AppConstant.baseHeaders}libs/portal/unify/portal.php/login/fail',
              'true': [
                'string',
                'string',
                'string',
                'string',
                'string',
                'string',
                'string'
              ]
            },
            options: Options(headers: {
              'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
              'Accept': '*/*',
              'Host': '192.168.100.252:8010',
              'Connection': 'keep-alive'
            }))
        .whenComplete(() => Log.i('已发送校园网认证请求'));
  }

  //检查账户是否正确
  Future<bool> checkAccount(String? user, String? password) async {
    await HttpUtil().post('/home.php?a=userlogin&c=login', data: {
      "a": "userlogin",
      "c": "login",
      'username': user,
      'password': password
    });
    // print(response);
    // print(HttpUtil().cookie);
    if (HttpUtil().cookie.toString().contains('check_user_pass=1')) {
      Log.i('$user,已登录校园网');
      return true;
    }
    Log.i('$user,账号或密码错误');
    return false;
  }

  //设备下线
  Future<bool> offline(String user, String password) async {
    await checkAccount(user, password);
    Response response = await HttpUtil()
        .get('/home.php/user/offline/user/$user', data: {
      "a": "userlogin",
      "c": "login",
      'username': user,
      'password': password
    });
    // print(response.data);
    if (response.toString().contains("下发离线指令成功！")) {
      Log.i('$user,已下发离线指令');
      return true;
    }
    Log.i('$user,下发离线指令失败');
    return false;
  }

  //获取套餐到期时间
  Future<String> expirationTime(String? user, String? password) async {
    HttpUtil().dio?.options.responseType = ResponseType.bytes;
    try {
      Response response = await HttpUtil().get('/home.php/user/server', data: {
        "a": "userlogin",
        "c": "login",
        'username': user,
        'password': password
      });
      if (response.statusCode == 200) {
        final regex = RegExp(r'过期时间：([^<]+)');
        final match = regex.firstMatch(Utils().gbkToUtf8(response));

        if (match != null) {
          final expirationDate = match.group(1);
          return expirationDate.toString();
        }
      }
    } catch (e) {
      Log.i('Error fetching data: $e');
      return "出错啦";
    }
    return '暂未登录';
  }

  //获取校园网账号实名状态
  Future<AccountStatus> realNameStatus(String? user, String? password) async {
    HttpUtil().dio?.options.responseType = ResponseType.bytes;
    try {
      Response response = await HttpUtil().get('/home.php/user/edit', data: {
        "a": "userlogin",
        "c": "login",
        'username': user,
        'password': password
      });
      if (response.statusCode == 200) {
        if (Utils().gbkToUtf8(response).toString().contains('您已经完成实名认证')) {
          return AccountStatus.Normal;
        }
      }
    } catch (e) {
      Log.i('Error fetching data: $e');
      return AccountStatus.Error;
    }
    return AccountStatus.Not_Real_Name;
  }
}
