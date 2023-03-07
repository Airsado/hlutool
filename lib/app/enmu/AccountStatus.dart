/// @Author Airsado
/// @Date 2023-09-19 0:42
/// @Version 1.0
/// @Description 账号状态
class AccountStatus {
  static const Not_Real_Name = AccountStatus._('未实名');
  static const Expired = AccountStatus._('已到期');
  static const Normal = AccountStatus._('账号正常');
  static const Paused = AccountStatus._('停机保号');
  static const Error = AccountStatus._('出错啦~');

  final String _value;

  const AccountStatus._(this._value);

  String get value => _value;
}
