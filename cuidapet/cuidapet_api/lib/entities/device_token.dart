
class DeviceToken {
  final String? android;
  final String? ios;

  DeviceToken({
    this.android,
    this.ios,
  });

  List<String?> get tokens => [android, ios];
}
