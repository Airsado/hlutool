import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hlutool/app/theme/values/AppColors.dart';

import '../../theme/values/AppSize.dart';

/// @Author Airsado
/// @Date 2023-09-10 11:21
/// @Version 1.0
/// @Description 应用顶部的titleBar和一些最小化、关闭按钮

class BarSide extends StatelessWidget {
  const BarSide({super.key, this.child, this.settingWidget});

  final Widget? child;
  final Widget? settingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: WindowTitleBarBox(
        child: Row(
          children: [
            Expanded(
                child: MoveWindow(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 12),
                        child: child))),
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                      width: AppSize.windowsBarButtonSize,
                      height: AppSize.windowsBarButtonSize,
                      child: settingWidget),
                ),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                        width: AppSize.windowsBarButtonSize,
                        height: AppSize.windowsBarButtonSize,
                        child: MinimizeWindowButton(
                            colors: AppColors.windowsBarButtonColor))),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                      width: AppSize.windowsBarButtonSize,
                      height: AppSize.windowsBarButtonSize,
                      child: CloseWindowButton(
                          colors: AppColors.windowsBarButtonColor)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
