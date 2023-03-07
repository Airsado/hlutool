import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:hlutool/until/store.dart';

import '../../app/views/navigation_view.dart';

//校园网请求类(检查账号密码、踢出设备，连接校园网)
class RequestNetWork {
  //检查账号密码是否正确
  checkUserPwd(user, pwd, localip) async {
    var dio = Dio();
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    String checkurl =
        'http://47.115.190.41/lfradius/home.php?a=userlogin&c=login';
    String offonlineurl =
        'http://47.115.190.41/lfradius/home.php/user/offline/user/$user';
    Map<String, dynamic> loginInfo = {
      "a": "userlogin",
      "c": "login",
      'username': '$user',
      'password': '$pwd'
    };
    await dio.post(checkurl,
        options: Options(followRedirects: true, headers: {
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
          "Accept-Encoding": "gzip, deflate",
          "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
          "Cache-Control": "max-age=0",
          "Connection": "keep-alive",
          "Content-Length": "44",
          "Content-Type": "application/x-www-form-urlencoded",
          "Cookie": "portal_wifi_connect=1; lf_timeout=1655378535",
          "Host": "47.115.190.41",
          "Origin": "http://47.115.190.41",
          "Referer":
              "http://47.115.190.41/lfradius/login.php?c=login&a=showlogin",
          "Upgrade-Insecure-Requests": "1",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.53",
        }),
        data: loginInfo);

    var cookie = await cookieJar.loadForRequest(Uri.parse(checkurl));

    if (cookie.toString().contains('check_user_pass=1')) {
      print('登录成功');
      //踢出设备（解决一个设备事先连接校园网，另一个设备开机启动自动登录时失效的问题）
      //通过firstOpen限制加载，只踢出设备一次，防止多次踢出造成联网后又被踢
      // print(firstOpen);
      if (firstOpen == true) {
        await dio.get(offonlineurl);
      }
      //连接校园网
      schoolNetConnect(user, pwd, localip);
      //记住密码运行逻辑
      if (await Store.readData('rememberpwd', false) == true) {
        Store.setData("user", user, true);
        Store.setData("pwd", pwd, true);
      } else {
        Store.setData("user", user, true);
        Store.removeData('pwd');
      }
      //登录成功
      return 2;
    } else {
      Store.setData("user", user, true);
      Store.removeData('pwd');
      print('登录失败');

      //登录失败
      return 3;
    }
  }

  //校园网连接
  schoolNetConnect(user, pwd, localip) async {
    var dio = Dio();

    String url =
        'http://192.168.100.252:8010/cgi-bin/webauth/ajax_webauth?action=login&user=$user&pwd=$pwd&usrmac=cc:cc:81:3f:0a:41&ip=$localip&success=http://47.115.190.41/lfradius/libs/portal/unify/portal.php/login/success/nastype/Panabit/basip/10.99.99.99/usrip/$localip&fail=http://47.115.190.41/lfradius/libs/portal/unify/portal.php/login/fail';

    await dio.post(url,
        options: Options(headers: {
          'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
          'Accept': '*/*',
          'Host': '192.168.100.252:8010',
          'Connection': 'keep-alive'
        }));
  }
}
