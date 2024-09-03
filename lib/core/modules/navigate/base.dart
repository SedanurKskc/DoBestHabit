abstract class BaseNavigationService {
  Future<void> nav({required String path, Object? arguments});
  Future<void> replace({required String path, Object? arguments});
  Future<void> clear({required String path, Object? arguments});
  Future<void> pop<T extends Object?>({T res});
  Future<void> popUntil({required int viewCount});
  Future<void> popHome();
}
