import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionManager {
  static ConnectionManager? _instance;
  static ConnectionManager get instance {
    _instance ??= ConnectionManager._init();
    return _instance!;
  }

  ConnectionManager._init();

  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnection() async {
    List<ConnectivityResult> connectivityResult = await (_connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
