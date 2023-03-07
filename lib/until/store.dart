import 'package:shared_preferences/shared_preferences.dart';

class Store {
  //写入数据(true为String,false为bool)
  static Future setData(String key, dynamic value, bool switchjson) async {
    final keepSave = await SharedPreferences.getInstance();
    // print('写入key为：$key,写入value为：$value');
    switchjson ? keepSave.setString(key, value) : keepSave.setBool(key, value);
    return true;
  }

  //读取数据(true为String,false为bool)
  static Future readData(String key, bool switchjson) async {
    var keepSave = await SharedPreferences.getInstance();
    var localdata =
        switchjson ? keepSave.getString(key) : keepSave.getBool(key);

    // print('写入key为：$key，获取到：$localdata');
    return localdata;
  }

  //删除数据
  static Future removeData(String key) async {
    final keepSave = await SharedPreferences.getInstance();
    keepSave.remove(key);
    // print('删除key为$key的值');
    return true;
  }
}
