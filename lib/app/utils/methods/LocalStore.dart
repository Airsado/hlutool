import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Log.dart';

/// @Author Airsado
/// @Date 2023-08-23 0:20
/// @Version 1.0
/// @Description 应用设置存储
class LocalStore {
  static final LocalStore _instance = LocalStore._internal();
  late Box settingsBox;

  factory LocalStore() {
    return _instance;
  }

  LocalStore._internal();

  Future<void> init() async {
    var dir = await getApplicationSupportDirectory();
    settingsBox = await Hive.openBox("appSettings", path: dir.path);
  }

  ///写入数据(true为String,false为bool)
  ///@pram：[key]为键，[value]为泛型值
  Future setData<T>(dynamic key, T value) async {
    Log.d("写入数据：$key\r\n$value");
    return settingsBox.put(key, value);
  }

  ///读取数据(true为String,false为bool)
  ///@pram：[key]为键，[defaultValue]为默认值，在获取数据为空时使用
  T? getData<T>(dynamic key, [T? defaultValue]) {
    var value = settingsBox.get(key, defaultValue: defaultValue) as T?;
    Log.d("获取数据：$key\r\n$value");
    return value;
  }

  ///删除数据
  ///@pram：[key]为键
  Future removeData(dynamic key) async {
    Log.d("删除数据：$key");
    return settingsBox.delete(key);
  }
}
