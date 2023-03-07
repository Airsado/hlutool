/// @Author Airsado
/// @Date 2023-09-11 21:47
/// @Version 1.0
/// @Description 程序的常量值

class AppConstant {
  //Dio请求的基础URL
  static const String baseUrl = "http://47.115.190.41/lfradius";

  //校园网认证的url地址
  static const String authUrl = 'http://192.168.100.252:8010/cgi-bin/webauth/ajax_webauth';

  //Dio请求的基础Headers
  static const Map<String, String> baseHeaders = {
    "Accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "Accept-Encoding": "gzip, deflate",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
    "Cache-Control": "max-age=0",
    "Connection": "keep-alive",
    "Content-Length": "44",
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "47.115.190.41",
    "Origin": "http://47.115.190.41",
    "Referer": "http://47.115.190.41/lfradius/login.php?c=login&a=showlogin",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.53",
  };


}
