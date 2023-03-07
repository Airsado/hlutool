import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hlutool/app/pages/about/aboutpage.dart';
import 'package:hlutool/app/pages/home/homepage.dart';
import 'package:hlutool/app/pages/network/networkpage.dart';

import 'package:hlutool/until/store.dart';
import 'package:intranet_ip/intranet_ip.dart';
import 'package:win32_registry/win32_registry.dart';
import 'app/pages/setting/settingpage.dart';
import 'app/views/navigation_view.dart';

void main(List<String> args) async {
  //为空则写入数据
  if (await Store.readData('rememberpwd', false) == null &&
      await Store.readData('Startup', false) == null &&
      await Store.readData('autologin', false) == null) {
    Store.setData("rememberpwd", true, false);
    Store.setData("Startup", true, false);
    Store.setData("autologin", false, false);
  }

  //获取数据，第一次打开未设置默认数据就先赋值默认数据
  localip = await intranetIpv4();
  rememberpwd = await Store.readData('rememberpwd', false) ?? true;
  Startup = await Store.readData('Startup', false) ?? true;
  autologin = await Store.readData('autologin', false) ?? false;

  //尝试读取本地登录的数据
  try {
    localuser = await Store.readData("user", true);
    localpwd = await Store.readData("pwd", true);
  } catch (err) {
    print(err);
  }
  //首次打开自动设置开机启动，若注册表里有启动项则不写入
  if (Startup == true) {
    final key = Registry.openPath(RegistryHive.currentUser,
        path: r'SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
        desiredAccessRights: AccessRights.allAccess); //寻找开机启动注册表
    final HluToolValue = key.getValueAsString('HluTool');
    // print(HluToolValue);
    if (HluToolValue == null) {
      const string = RegistryValue('HluTool', RegistryValueType.string,
          r'C:\Program Files (x86)\HluTool\hlutool.exe');
      key.createValue(string);
    }
  }
  runApp(FluentApp(
    title: '华联工具',
    initialRoute: '/',
    routes: {
      '/': (context) => const NavigationViews(),
      '/home': (context) => const HomePage(),
      '/network': (context) => const NetWorkPage(),
      '/about': (context) => const AboutPage()
    },
  ));
  //设置窗口大小
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(400, 550);
    win.minSize = initialSize;
    win.maxSize = initialSize;
    win.size = initialSize;
    win.title = '华联工具';
    win.show();
  });
}
