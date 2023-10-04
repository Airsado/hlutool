import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../data/api/CampusNetwork.dart';
import '../../../utils/methods/LocalStore.dart';
import '../../../utils/widgets/AccountBottomSheet.dart';
import '../../../utils/widgets/InfoCard.dart';
import '../../../utils/widgets/ProjectItem.dart';
import '../home_controller/HomeController.dart';

/// @Author Airsado
/// @Date 2023-08-23 22:55
/// @Version 1.0
/// @Description 程序首页视图
/// showModelBootomSheet 圆角解决方案：https://zhuanlan.zhihu.com/p/357234531
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Provider.of<HomeController>(context);
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
                              children: [
                                homeController.isLoading
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 2.0)
                                    : Text(homeController.loginStatus,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600)),
                                const Padding(
                                    padding: EdgeInsets.only(right: 35.0),
                                    child: Icon(Icons.golf_course_outlined))
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
                                    content: homeController.expirationTime),
                                InfoCard(
                                    title: '账号状态',
                                    content:
                                        homeController.accountStatus.value),
                                const SizedBox(width: 50),
                                ElevatedButton(
                                    onPressed: () =>
                                        homeController.connectButton(context),
                                    child: const Text("连接网络")),
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
                  onTap: () {
                    homeController.onTapTip(context);
                  }),
              ProjectItem(
                  icon: Icons.online_prediction_outlined,
                  title: '设备下线',
                  content: '敬请期待',
                  onTap: () {
                    homeController.onTapTip(context);
                  }),
            ]))
      ],
    );
  }
}
