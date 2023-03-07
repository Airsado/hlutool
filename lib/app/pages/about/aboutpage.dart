import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_update_dialog/flutter_update_dialog.dart';
import 'package:hlutool/until/VersionInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../until/request/checkUpdata.dart';
import '../../views/navigation_view.dart';
import '../home/homepage.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUpdata();
  }

  @override
  Widget build(BuildContext context) {
    return TabView(
        onChanged: (v) {
          setState(() {
            _currentIndex = v;
          });
        },
        tabWidthBehavior: TabWidthBehavior.equal,
        closeButtonVisibility: CloseButtonVisibilityMode.never,
        currentIndex: _currentIndex,
        tabs: [
          Tab(
              text: const Text("此软件"),
              body: Column(
                children: [
                  ListTile(
                    // leading: const Icon(FluentIcons.update_restore),
                    title: const Text('当前版本'),
                    trailing: TextButton(
                        child: FutureBuilder(
                            future: checkUpdata(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: ProgressRing()),
                                    SizedBox(width: 5),
                                    Text('检查更新中...')
                                  ],
                                );
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data['versionCode'] ==
                                    ExeInfo.VersionCode) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('V${ExeInfo.Version}')
                                    ],
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('New：${snapshot.data['version']}',
                                          style: TextStyle(color: Colors.red))
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return const Icon(FluentIcons.error_badge);
                              } else {
                                return const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: ProgressRing());
                              }
                            }),
                        onPressed: () {
                          if (ExeInfo.VersionCode < versionCode) {
                            UpdataTip();
                          } else {
                            CherryToast.warning(
                              animationType: AnimationType.fromTop,
                              title: const Text('版本已为最新(❁´◡`❁)',
                                  style: TextStyle(fontSize: 10)),
                              borderRadius: 0,
                            ).show(context);
                          }
                        }),
                  ),
                  const Expander(
                    header: Text('当前版本日志'),
                    content: SizedBox(
                      height: 80,
                      child: SingleChildScrollView(
                        child: Text(ExeInfo.NowUpdataHistory),
                      ),
                    ),
                  )
                ],
              ),
              icon: const Icon(FluentIcons.user_window)),
          Tab(
              text: const Text("屑作者"),
              body: Column(
                children: [
                  Image.network(
                    'https://www.airsado.cn/usr/uploads/2023/01/313413215.jpg',
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        const Text('有BUG可以反馈，尽量修复'),
                        Image.asset(
                          'assets/images/addWx.jpg',
                          width: 300,
                          height: 300,
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  )
                ],
              ),
              icon: const Icon(FluentIcons.external_user)),
        ]);
  }

  //更新相关
  UpdateDialog? Updatadialog;

  void UpdataTip() async {
    Updatadialog = UpdateDialog.showUpdate(context,
        // topImage: Image.network(''),
        title: title,
        updateContent: updateContent, onUpdate: () async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    });
  }
}
