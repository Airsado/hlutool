import 'package:flutter/material.dart';
import 'package:hlutool/app/theme/values/AppImages.dart';
import 'package:hlutool/app/theme/values/AppSize.dart';
import 'package:hlutool/app/theme/values/Values.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Author Airsado
/// @Date 2023-09-11 0:36
/// @Version 1.0
/// @Description 关于页面

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: AppSize.Spacing10),
      SizedBox(child: Image.asset(AppImage.backGroundImg)),
      Container(
          padding: const EdgeInsets.all(16.0),
          height: 320,
          child: ListView(children: [
            Row(children: const [
              Text("链接",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
            ]),
            const SizedBox(height: AppSize.Spacing10),
            Wrap(children: [
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isDismissible: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 300,
                                      child: Image.asset(AppImage.wechatCode)),
                                  const SizedBox(height: AppSize.Spacing10),
                                  const Text("请备注来意，谢谢！！")
                                ]),
                          );
                        });
                  },
                  child: const Text("添加微信")),
              TextButton(
                  onPressed: () => _launchUrl(AppConstant.officialUrl),
                  child: const Text("访问官网")),
              Badge(
                  isLabelVisible: false,
                  child: TextButton(
                      onPressed: () {
                        _launchUrl(Uri.parse("https://hlu.airsado.cn/"));
                      },
                      child: const Text("去更新"))),
              TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () => _launchUrl(AppConstant.blogUrl),
                  child: const Text("作者博客")),
              TextButton(
                  onPressed: () => _launchUrl(AppConstant.githubUrl),
                  child: const Text("Github")),
            ]),
          ]))
    ]);
  }
}
