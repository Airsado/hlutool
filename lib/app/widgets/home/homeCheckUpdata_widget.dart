import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:hlutool/until/VersionInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../pages/home/homepage.dart';
import '../../views/navigation_view.dart';

class HomeCheckUpdataWidget extends StatefulWidget {
  const HomeCheckUpdataWidget({Key? key}) : super(key: key);

  @override
  State<HomeCheckUpdataWidget> createState() => _HomeCheckUpdataWidgetState();
}

class _HomeCheckUpdataWidgetState extends State<HomeCheckUpdataWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
            'http://q.qlogo.cn/headimg_dl?dst_uin=1798361738&spec=640&img_type=jpg',
            width: 60,
            height: 60),
        const SizedBox(width: 10),
        FutureBuilder(
            future: inkwell,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(children: const [
                  SizedBox(width: 20, height: 20, child: ProgressRing()),
                  SizedBox(width: 5),
                  Text('检查更新中..')
                ]);
              }

              if (snapshot.hasData) {
                int versionCode = snapshot.data['versionCode'];
                return InfoBar(
                    isLong: false,
                    title: ExeInfo.VersionCode > versionCode ||
                            ExeInfo.VersionCode == versionCode
                        ? const Text('已为最新版本')
                        : const Text('检查到最新版本'),
                    content: const Text(
                      ExeInfo.Version,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    severity: ExeInfo.VersionCode > versionCode ||
                            ExeInfo.VersionCode == versionCode
                        ? InfoBarSeverity.success
                        : InfoBarSeverity.error,
                    action: ExeInfo.VersionCode > versionCode ||
                            ExeInfo.VersionCode == versionCode
                        ? null
                        : Button(
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
                            },
                            child: const Text('去更新'),
                          ));
              } else if (snapshot.hasError) {
                return Row(
                  children: const [
                    SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(FluentIcons.error_badge)),
                    Text('检查失败')
                  ],
                );
              } else {
                return const SizedBox(
                    width: 20, height: 20, child: ProgressRing());
              }
            })
      ],
    );
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
