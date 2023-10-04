import 'dart:io';
import 'package:win32_registry/win32_registry.dart';

/// @Author Airsado
/// @Date 2023-08-23 14:54
/// @Version 1.0
/// @Description 开机自启注册表写入
class Register {
  static final Register _instance = Register._internal();

  factory Register() => _instance;

  late final key;

  Register._internal() {
    key = Registry.openPath(RegistryHive.currentUser,
        path: r'SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
        desiredAccessRights: AccessRights.allAccess);
  }

  ///写入到开机启动注册表
  void writeBootStrapRegister() {
    //寻找开机启动注册表
    final value = key.getValueAsString('HluTool');

    //如果为空，则写入开机启动
    if (value == null) {
      //获取dart可执行文件路径
      String running = Platform.resolvedExecutable;
      RegistryValue string =
          RegistryValue('HluTool', RegistryValueType.string, running);
      key.createValue(string);
    }
  }

  //删除启动注册表
  void removeRegister() {
    key.deleteValue('HluTool');
  }
}
