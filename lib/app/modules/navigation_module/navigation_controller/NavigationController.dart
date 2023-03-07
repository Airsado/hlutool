import 'package:flutter/material.dart';
import 'package:hlutool/app/modules/about_module/about_page/AboutView.dart';
import 'package:hlutool/app/modules/home_module/home_page/HomeView.dart';

/// @Author Airsado
/// @Date 2023-09-11 0:45
/// @Version 1.0
/// @Description 底部导航相关控制、请求

class NavigationController {
  static final NavigationController _instance = NavigationController._();

  factory NavigationController() {
    return _instance;
  }

  NavigationController._();

  /// 底部导航栏
  static final List<Widget> navigationList = [
    const HomeView(),
    const AboutView()
  ];

  /// 底部导航当前索引
  static int currentIndex = 0;

}
