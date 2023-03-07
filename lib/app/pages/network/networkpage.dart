import 'dart:async';
import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hlutool/until/store.dart';
import '../../../until/request/request_network.dart';
import '../../views/navigation_view.dart';
import '../home/homepage.dart';

class NetWorkPage extends StatefulWidget {
  const NetWorkPage({Key? key}) : super(key: key);

  @override
  State<NetWorkPage> createState() => _NetWorkPageState();
}

//是否查看密码
bool obscureText = true;

//获取内网ip
var localip;

//本地数据
String? localuser;
String? localpwd;

//是否记住密码
bool? rememberpwd = false;
//是否自动登录
bool? autologin = false;

bool? changeRememberpwd(bool? value) {
  rememberpwd = value;
}

bool? changeAutoLogin(bool? value) {
  autologin = value;
  if (autologin == true) {
    rememberpwd = true;
  }
}

//获取用户名
final TextEditingController _UserController =
    TextEditingController(text: localuser);

//获取密码
final TextEditingController _PasswordController =
    TextEditingController(text: localpwd);

class _NetWorkPageState extends State<NetWorkPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Container(
                width: 300,
                child: TextBox(
                  controller: _UserController,
                  placeholder: '请输入校园网账号',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextBox(
                  obscureText: obscureText,
                  controller: _PasswordController,
                  suffix: IconButton(
                    icon: const Icon(FluentIcons.red_eye12),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  placeholder: '请输入校园网密码',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Checkbox(
                        content: const Text('记住密码'),
                        checked: rememberpwd,
                        onChanged: (bool? value) {
                          Store.setData('rememberpwd', value, true);
                          changeRememberpwd(value);
                          setState(() {});
                        },
                      ),
                      Checkbox(
                        content: const Text('自动登录'),
                        checked: autologin,
                        onChanged: (bool? value) async {
                          Store.setData('autologin', value, false);
                          setState(() {
                            changeAutoLogin(value);
                          });
                        },
                      ),
                      Expanded(child: Container()),
                      Button(
                          child: const Text('修改密码'),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/t');
                          })
                    ],
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: Row(children: [
                  FutureBuilder(
                      future: loginfuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.none) {
                          return Container();
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                              width: 20, height: 20, child: ProgressRing());
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data == 2) {
                            return const Icon(FluentIcons.accept);
                          } else {
                            return const Icon(FluentIcons.error_badge);
                          }
                        } else if (snapshot.hasError) {
                          return const Icon(FluentIcons.error_badge);
                        } else {
                          return const SizedBox(
                              width: 20, height: 20, child: ProgressRing());
                        }
                      }),
                  const SizedBox(width: 10),
                  FilledButton(
                      child: const Text('登录', style: TextStyle(fontSize: 17)),
                      onPressed: () async {
                        if (_UserController.text.isNotEmpty &&
                            _PasswordController.text.isNotEmpty) {
                          setState(() {
                            loginfuture = RequestNetWork().checkUserPwd(
                                _UserController.text,
                                _PasswordController.text,
                                localip.address);
                          });
                        } else if (_UserController.text.isEmpty ||
                            _PasswordController.text.isEmpty) {
                          CherryToast.warning(
                            animationType: AnimationType.fromRight,
                            title: const Text('你家校园网没有账号或者密码呀？！(╯°□°）╯︵ ┻━┻',
                                style: TextStyle(fontSize: 10)),
                            borderRadius: 0,
                          ).show(context);
                        }
                      })
                ]),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                  width: 300,
                  child: InfoBar(
                    title: Text('注意了！'),
                    content: Text(
                      '本软件不会远程获取您的账号和密码。只会将账号密码保存在您的本地电脑中',
                    ),
                    severity: InfoBarSeverity.info,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
