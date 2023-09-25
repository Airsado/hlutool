import 'package:logger/logger.dart';

///logger错误输出
///[d]为Debug信息
///[i]为Info错误
///[e]为Error错误
///[w]为Warring错误
class Log {
  static final Log _instance = Log._internal();

  factory Log() => _instance;

  Log._internal();

  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  ///Debug log
  static d(String message) {
    logger.d("${DateTime.now().toString()}\n$message");
  }

  ///Info log
  static i(String message) {
    logger.i("${DateTime.now().toString()}\n$message");
  }

  ///Error log
  static e(String message, StackTrace stackTrace) {
    logger.e("${DateTime.now().toString()}\n$message", null, stackTrace);
  }

  ///Warning log
  static w(String message) {
    logger.w("${DateTime.now().toString()}\n$message");
  }
}
