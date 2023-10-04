import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hlutool/app/utils/methods/LocalStore.dart';
import 'package:hlutool/app/utils/methods/NetshUtils.dart';
import 'package:hlutool/app/utils/methods/log.dart';

import '../../../data/api/CampusNetwork.dart';
import '../../../enmu/AccountStatus.dart';
import '../../../utils/widgets/AccountBottomSheet.dart';

/// @Author Airsado
/// @Date 2023-09-13 13:04
/// @Version 1.0
/// @Description 首页相关交互以及一些controller
class HomeController with ChangeNotifier {
  static final HomeController _instance = HomeController._internal();

  factory HomeController() {
    return _instance;
  }

  HomeController._internal();

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final CampusNetwork _campusNetwork = CampusNetwork();
  late String expirationTime = '暂未登录';
  late AccountStatus accountStatus = AccountStatus.Not_Real_Name;

  String loginStatus = "未认证";
  bool isLoading = false;

  // late final String? _user = LocalStore().getData('user');
  // late final String? _password = LocalStore().getData('password');

  // 提交并保存 方法
  void submitAndSave(BuildContext context) {
    CampusNetwork()
        .checkAccount(accountController.text, passwordController.text)
        .then((value) {
      if (value) {
        Log.i('保存用户信息成功');
        LocalStore().setData('user', accountController.text);
        LocalStore().setData('password', passwordController.text);
        _updateAccountInfo();
        _authNetwork();
        Navigator.pop(context);
      } else {
        isLoading = false;
        loginStatus = "账号或密码错误";
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 1000), () {
          loginStatus = "未认证";
          notifyListeners();
        });
      }
    });
  }

  //更新首页账号信息
  Future<void> _updateAccountInfo() async {
    expirationTime = await _campusNetwork.expirationTime(
        LocalStore().getData('user'), LocalStore().getData('password'));
    accountStatus = await _campusNetwork.realNameStatus(
        LocalStore().getData('user'), LocalStore().getData('password'));
    notifyListeners();
  }

  //认证校园网逻辑
  void _authNetwork() {
    CampusNetwork()
        .authentication(
            LocalStore().getData('user'), LocalStore().getData('password'))
        .then((value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        isLoading = false;
        loginStatus = "已认证";
        notifyListeners();
      });
    });
  }

  void _setWlanProfile() async {
    String profileList = await NetshUtils().showProfile();
    if (!profileList.contains("stu-wifi") || !profileList.contains("hlu-stu")) {
      await NetshUtils().addWlanXml();
    }
  }

  //连接网络按钮逻辑
  void connectButton(BuildContext context) {
    if (LocalStore().getData('user') == null ||
        LocalStore().getData('password') == null) {
      showModalBottomSheet(
          isDismissible: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12))),
          context: context,
          builder: (BuildContext context) {
            return const AccountBottomSheet();
          });
    } else {
      isLoading = true;
      _setWlanProfile();
      _authNetwork();
    }
    notifyListeners();
  }

  //点击提示
  void onTapTip(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: const Text("功能正在开发验证中，敬请期待~"),
              actions: <Widget>[
                TextButton(
                    child: const Text("了解！！"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }
}
