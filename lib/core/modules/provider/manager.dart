import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import '../navigate/manager.dart';
import 'bottombar.dart';
import 'theme.dart';
export 'theme.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    ChangeNotifierProvider(create: (context) => BottomBarNotifier()),
    Provider.value(value: NavigationManager.instance),
  ];
}
