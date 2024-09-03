class ApplicationSetup {
  static ApplicationSetup? _instance;
  static ApplicationSetup get instance {
    _instance ??= ApplicationSetup._init();
    return _instance!;
  }

  ApplicationSetup._init();

  ///Manage theme status active or not
  static bool multiThemeActive = false;

  ///Manage feature status active or not
  static bool get featureActive => true;

  ///Manage feature status active or not
  static bool get adsActive => true;

  ///Manage App mode
  static AppMode get _appMode => AppMode.dev;
  AppMode get appMode => _appMode;
  String get url => appMode.url;
}

enum AppMode {
  test(url: 'xxx.xxx', path: 'api'),
  dev(url: 'xxx.xxx', path: 'api'),
  product(url: 'xxx.xxx', path: 'api');

  final String url;
  final String path;
  const AppMode({required this.url, this.path = ""});
}
