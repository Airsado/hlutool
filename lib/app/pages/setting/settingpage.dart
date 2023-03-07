import 'package:fluent_ui/fluent_ui.dart';

import 'package:win32_registry/win32_registry.dart';
import '../../../until/store.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

var Startup;

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
          title: ToggleSwitch(
            content: const Text('开机启动'),
            checked: Startup,
            onChanged: (bool value) async {
              Store.setData('Startup', value, false);
              Store.readData('Startup', false);
              setState(() {
                Startup = value;
              });
              // print('本地${await Store.readData('Startup', false)}');
              // print('值$Startup');
              // print('value值$value');
              final key = Registry.openPath(RegistryHive.currentUser,
                  path: r'SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
                  desiredAccessRights: AccessRights.allAccess); //寻找开机启动注册表

              if (Startup == true) {
                const string = RegistryValue(
                    'HluTool', RegistryValueType.string,
                    r'C:\Program Files (x86)\HluTool\hlutool.exe');
                key.createValue(string);
              } else if (Startup == false) {
                key.deleteValue('HluTool');
              }


            },
          ))
    ]);
  }
}
