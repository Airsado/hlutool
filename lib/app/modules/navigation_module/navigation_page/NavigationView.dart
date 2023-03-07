import 'package:flutter/material.dart';
import 'package:hlutool/app/enmu/Channel.dart';
import 'package:hlutool/app/modules/navigation_module/navigation_controller/NavigationController.dart';

import '../../../theme/values/AppImages.dart';
import '../../../theme/values/AppSize.dart';
import '../../../utils/widgets/BarSide.dart';

/// @Author Airsado
/// @Date 2023-09-11 0:43
/// @Version 1.0
/// @Description 底部导航

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0x0080FFFF)],
              stops: [0.35, 1.0]),
        ),
        child: Column(children: [
          BarSide(
              child: Row(children: [
            Image.asset(AppImage.logo),
            const SizedBox(width: AppSize.Spacing5),
            const Text('HLUTOOL', style: TextStyle(fontSize: 15)),
            const SizedBox(width: AppSize.Spacing5),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(1.0))),
                alignment: Alignment.center,
                width: 32,
                height: 20,
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppChannel.BETA.appChannel,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ))
          ])),
          NavigationController.navigationList[NavigationController.currentIndex]
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              NavigationController.currentIndex = index;
              // print(NavigationController.currentIndex);
            });
          },
          currentIndex: NavigationController.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: '关于'),
          ]),
    );
  }
}
