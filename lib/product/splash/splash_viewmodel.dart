import '../../core/base/state/base_state.dart';
import '../../core/modules/memory/prefs/prefs_manager.dart';
import 'splash_view.dart';

abstract class SplashViewmodel extends BaseState<SplashView> {
  bool userLoggedIn = false;
  bool isFirstOpen = false;

  @override
  void initState() {
    super.initState();
    userLoggedIn = PreferencesManager.getBoolVal(PrefsKeys.userLoggedIn) ?? false;
    isFirstOpen = PreferencesManager.getBoolVal(PrefsKeys.isFirstOpen) ?? true;
  }
}
