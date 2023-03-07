import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hlutool/app/pages/home/homepage.dart';
import '../pages/about/aboutpage.dart';
import '../pages/message/messagepage.dart';
import '../pages/network/networkpage.dart';
import '../pages/setting/settingpage.dart';

import '../widgets/rightside.dart';

class NavigationViews extends StatefulWidget {
  const NavigationViews({Key? key}) : super(key: key);

  @override
  State<NavigationViews> createState() => _NavigationViewsState();
}

Future? loginfuture;
Future? inkwell;
final Uri url = Uri.parse(updataUrl);
var version;
var versionCode;
var title;
var updateContent;
var updataUrl;
var topImage;
//官方链接
final Uri Blogurl = Uri.parse('https://hlu.airsado.cn/');
int topIndex = 0;
//首次打开
bool? firstOpen = true;

class _NavigationViewsState extends State<NavigationViews> {
  //网络连接状态
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<ConnectivityResult> _updateConnectionStatus(
      ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
    print(result);
    return result;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        size: const NavigationPaneSize(openWidth: 120),
        header: const Text('华联工具'),
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('首页'),
            body: RightSide(chill: const HomePage()),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.network_tower),
            title: const Text('校园网'),
            // infoBadge: const InfoBadge(source: Text('8')),
            body: RightSide(chill: const NetWorkPage()),
          ),
          PaneItem(
              icon: const Icon(FluentIcons.message),
              title: const Text('留言墙'),
              body: RightSide(chill: const MessagePage())),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('设置'),
            body: RightSide(chill: const SettingPage()),
          ),
          PaneItem(
              icon: const Icon(FluentIcons.accounts),
              title: const Text('关于'),
              body: RightSide(chill: const AboutPage()))
        ],
      ),
    );
  }
}
