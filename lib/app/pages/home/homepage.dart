import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:hlutool/app/pages/network/networkpage.dart';
import 'package:hlutool/app/widgets/home/state_widget.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../until/request/checkUpdata.dart';
import '../../../until/request/request_network.dart';
import '../../views/navigation_view.dart';

import '../../widgets/home/homeCheckUpdata_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //检测更新
    if (firstOpen == true) {
     inkwell= checkUpdata();
    }
    if (autologin == true && firstOpen == true) {
      loginfuture =
          RequestNetWork().checkUserPwd(localuser, localpwd, localip.address);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //切换页面后赋值为false，防止二次切换首页继续加载future
    firstOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StateWidget(),
        const SizedBox(height: 10),
        Expanded(child: Container()),
        Text("已知15栋使用正常，其他楼栋情况欢迎反馈",
            style: TextStyle(fontSize: 18, color: Colors.red)),
        const Text("设置好后实现电脑开机自动登录校园网"),
        const Text("建议勾选自动登录设置"),
        Text("有BUG可以反馈（软件左下角关于页面）", style: TextStyle(color: Colors.red)),
        const SizedBox(height: 10),
        Expanded(child: Container()),
        const HomeCheckUpdataWidget(),
        TextButton(
            child: Text("hlu.airsado.cn",
                style: TextStyle(fontSize: 20, color: Colors.blue)),
            onPressed: () async {
              if (await canLaunchUrl(Blogurl)) {
                await launchUrl(Blogurl);
              } else {
                throw 'Could not launch $Blogurl';
              }
            }),
      ],
    );
  }
}
