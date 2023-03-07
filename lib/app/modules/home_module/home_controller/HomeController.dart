import 'package:flutter/cupertino.dart';
import 'package:hlutool/app/utils/methods/LocalStore.dart';
import 'package:hlutool/app/utils/methods/log.dart';

import '../../../data/api/CampusNetwork.dart';
import '../../../enmu/AccountStatus.dart';

/// @Author Airsado
/// @Date 2023-09-13 13:04
/// @Version 1.0
/// @Description 首页相关交互以及一些controller
class HomeController {
  static HomeController? _instance;

  factory HomeController() {
    // controller被销毁后重新创建一个新的单例
    _instance ??= HomeController._internal();
    return _instance!;
  }

  HomeController._internal();

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final CampusNetwork _campusNetwork = CampusNetwork();
  late String expirationTime = '暂未登录';
  late AccountStatus accountStatus = AccountStatus.Not_Real_Name;

  late final String? _user = LocalStore().getData('user');
  late final String? _password = LocalStore().getData('password');

  // 提交并保存 方法
  void submitAndSave() {
    CampusNetwork()
        .checkAccount(accountController.text, passwordController.text)
        .then((value) {
      if (value) {
        Log.i('保存用户信息成功');
        LocalStore().setData('user', accountController.text);
        LocalStore().setData('password', passwordController.text);
      }
    });
  }

  //抓取校园网账号过期时间
  Future<void> fetchExpirationTime() async {
    expirationTime = await _campusNetwork.expirationTime(_user, _password);
  }

  //抓取校园网账号状态
  Future<void> fetchRealNameStatus() async {
    accountStatus = await _campusNetwork.realNameStatus(_user, _password);
  }

  // 销毁方法
  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    _instance = null;
  }
}
