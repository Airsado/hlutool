import 'dart:io';
import 'package:win32_registry/win32_registry.dart';

/// @Author Airsado
/// @Date 2023-08-23 14:54
/// @Version 1.0
/// @Description 开机自启注册表写入
class Register {
  ///写入到开机启动注册表
  void writeBootStrapRegister() {
    final key = Registry.openPath(RegistryHive.currentUser,
        path: r'SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
        desiredAccessRights: AccessRights.allAccess);

    //寻找开机启动注册表
    final value = key.getValueAsString('HluTool');

    //如果为空，则写入开机启动
    if (value == null) {
      String running = Platform.resolvedExecutable.replaceAll("\\", "\\\\");
      RegistryValue string =
          RegistryValue('HluTool', RegistryValueType.string, running);
      key.createValue(string);
    }
  }
}
