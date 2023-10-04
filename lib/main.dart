import 'dart:async';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hlutool/app/data/api/CampusNetwork.dart';
import 'package:hlutool/app/modules/home_module/home_controller/HomeController.dart';
import 'package:hlutool/app/modules/navigation_module/navigation_controller/NavigationController.dart';
import 'package:hlutool/app/utils/methods/LocalStore.dart';
import 'package:hlutool/app/utils/methods/Register.dart';
import 'package:provider/provider.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'app/modules/about_module/about_page/AboutView.dart';
import 'app/modules/home_module/home_page/HomeView.dart';
import 'app/modules/navigation_module/navigation_page/NavigationView.dart';
import 'app/utils/methods/Log.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStore().init();
  await CampusNetwork().checkAccount(
      LocalStore().getData('user'), LocalStore().getData('password'));

  if (await LocalStore().getData('bootStrap') == null) {
    await LocalStore().setData("bootStrap", true);
    Register().writeBootStrapRegister();
  }

  //全局异常捕获
  runZonedGuarded(() async {
    // 单实例启动
    await WindowsSingleInstance.ensureSingleInstance(args, "airStudio_hlutool",
        onSecondWindow: (args) {
      // print(args);
    });
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationController>(
            create: (_) => NavigationController()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '华联工具',
        initialRoute: '/',
        routes: {
          '/': (context) => const NavigationView(),
          '/home': (context) => const HomeView(),
          '/about': (context) => const AboutView(),
        },
      ),
    ));
    //初始化窗口大小
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(400, 660);
      win.minSize = initialSize;
      win.maxSize = initialSize;
      win.size = initialSize;
      win.title = '华联工具';
      win.show();
    });
  }, (error, stack) {
    Log.e(error.toString(), stack);
  });
}
