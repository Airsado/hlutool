import 'package:flutter/material.dart';
import 'package:hlutool/app/data/api/CampusNetwork.dart';
import 'package:hlutool/app/modules/home_module/home_controller/HomeController.dart';
import 'package:hlutool/app/theme/values/AppImages.dart';
import 'package:hlutool/app/theme/values/AppSize.dart';
import 'package:hlutool/app/utils/methods/LocalStore.dart';
import 'InputField.dart';

/// @Author Airsado
/// @Date 2023-09-13 10:46
/// @Version 1.0
/// @Description 保存校园网账号密码的widget
class AccountBottomSheet extends StatefulWidget {
  const AccountBottomSheet({super.key});

  @override
  State<AccountBottomSheet> createState() => _AccountBottomSheetState();
}

class _AccountBottomSheetState extends State<AccountBottomSheet> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    HomeController().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            Image.asset(AppImage.logo, width: 25),
            const SizedBox(width: AppSize.Spacing5),
            const Text("请保存校园网账号密码(●ˇ∀ˇ●)", style: TextStyle(fontSize: 18))
          ]),
          SizedBox(
              height: 175,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                      controller: HomeController().accountController,
                      hintText: '请输入校园网账号',
                    ),
                    InputField(
                        prefixIcon: const Icon(Icons.key_outlined),
                        controller: HomeController().passwordController,
                        hintText: '请输入校园网密码',
                        obscureText: true),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(onPressed: () {}, child: const Text("忘记密码？"))
                    ]),
                  ])),
          ElevatedButton(
            onPressed: () {
              HomeController().submitAndSave();
            },
            child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 35,
                child: const Text("验证并保存")),
          ),
        ],
      ),
    );
  }
}
