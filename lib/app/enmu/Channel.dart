/// @Author Airsado
/// @Date 2023-09-13 16:12
/// @Version 1.0
/// @Description 程序渠道版本

class AppChannel {
  static const BETA = AppChannel._('Beta');
  static const RELEASE = AppChannel._('Release');
  static const TEST = AppChannel._('Test');

  final String _channel;

  const AppChannel._(this._channel);

  String get appChannel => _channel;
}
