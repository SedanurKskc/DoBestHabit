import 'prefs/prefs_manager.dart';

class MemoryManager {
  static MemoryManager? _instance;
  static MemoryManager get instance {
    _instance ??= MemoryManager._init();
    return _instance!;
  }

  MemoryManager._init();

  Future<void> init() async {
    await PreferencesManager.init();
  }
}
