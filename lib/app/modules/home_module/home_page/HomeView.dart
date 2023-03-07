import 'package:flutter/material.dart';
import 'package:hlutool/app/theme/values/AppImages.dart';
import 'package:hlutool/app/theme/values/AppSize.dart';
import 'package:hlutool/app/utils/widgets/BarSide.dart';
import 'package:hlutool/app/utils/widgets/ConnectionInfo.dart';

/// @Author Airsado
/// @Date 2023-08-23 22:55
/// @Version 1.0
/// @Description 程序首页视图
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const ConnectionInfo();
  }
}
