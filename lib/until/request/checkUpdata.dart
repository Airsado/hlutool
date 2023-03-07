import 'package:dio/dio.dart';

import '../../app/views/navigation_view.dart';

checkUpdata() async {
  Dio dio = Dio();
  var response = await dio.get('https://www.airsado.cn/hlutool.json');
  var Info = response.data['hlutool'][0];
  version = Info['version'];
  versionCode = Info['versionCode'];
  title = Info['title'];
  updateContent = Info['updateContent'];
  updataUrl = Info['updataUrl'];
  topImage = Info['topImage'];

  return Info;
}
