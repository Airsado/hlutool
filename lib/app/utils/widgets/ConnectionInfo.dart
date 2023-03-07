import 'package:flutter/material.dart';
import 'package:hlutool/app/modules/home_module/home_controller/HomeController.dart';
import 'package:hlutool/app/utils/widgets/AccountBottomSheet.dart';
import 'package:hlutool/app/utils/widgets/ProjectItem.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../data/api/CampusNetwork.dart';
import '../../enmu/AccountStatus.dart';
import '../methods/LocalStore.dart';
import 'InfoCard.dart';

/// @Author Airsado
/// @Date 2023-09-10 16:06
/// @Version 1.0
/// @Description 应用程序连接信息
/// showModelBootomSheet 圆角解决方案：https://zhuanlan.zhihu.com/p/357234531
class ConnectionInfo extends StatefulWidget {
  const ConnectionInfo({super.key});

  @override
  State<ConnectionInfo> createState() => _ConnectionInfoState();
}

class _ConnectionInfoState extends State<ConnectionInfo> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([
      _homeController.fetchExpirationTime(),
      _homeController.fetchRealNameStatus()
    ]).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            height: 210,
            // color: Colors.red,
            child: Stack(children: [
              WaveWidget(
                  config: CustomConfig(
                    colors: const [Color(0x73B7F3B1), Color(0x73B7F3B1)],
                    durations: [6000, 4000],
                    heightPercentages: const [0.0, 0.0],
                    blur: const MaskFilter.blur(BlurStyle.normal, 5),
                  ),
                  size: const Size(double.infinity, double.infinity)),
              Positioned(
                  top: 33,
                  child: SizedBox(
                      width: 365,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("连接成功",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600)),
                                Padding(
                                    padding: EdgeInsets.only(right: 35.0),
                                    child: Icon(Icons.abc_outlined))
                              ])))),
              Positioned(
                  top: 115,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                          width: 365,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InfoCard(
                                    title: '过期时间',
                                    content: _homeController.expirationTime),
                                InfoCard(
                                    title: '账号状态',
                                    content:
                                        _homeController.accountStatus.value),
                                const SizedBox(width: 50),
                                ElevatedButton(
                                    onPressed: () {
                                      if (LocalStore().getData('user') ==
                                              null ||
                                          LocalStore().getData('password') ==
                                              null) {
                                        showModalBottomSheet(
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    topLeft:
                                                        Radius.circular(12))),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AccountBottomSheet();
                                            });
                                      } else {
                                        CampusNetwork().authentication(
                                            LocalStore().getData('user'),
                                            LocalStore().getData('password'));
                                      }
                                      CampusNetwork().expirationTime(
                                          LocalStore().getData('user'),
                                          LocalStore().getData('password'));
                                    },
                                    child: const Text("连接网络")),
                                // CircularProgressIndicator()
                              ]))))
            ])),
        SizedBox(
            width: double.infinity,
            height: 350,
            child: ListView(children: [
              ProjectItem(
                  icon: Icons.key_outlined,
                  title: '修改密码',
                  content: '敬请期待',
                  onTap: () {}),
              ProjectItem(
                  icon: Icons.online_prediction_outlined,
                  title: '设备下线',
                  content: '敬请期待',
                  onTap: () {}),
            ]))
      ],
    );
  }
}
