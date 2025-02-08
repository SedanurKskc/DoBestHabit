import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/base/state/base_state.dart';
import '../../modules/daily/daily_model.dart';
import 'daily_view.dart';

abstract class DailyViewmodel extends BaseState<DailyView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DailyModel>> getDailys() {
    return _firestore.collection("daily").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DailyModel.fromMap(doc.data() as Map<String, dynamic>,doc.id);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
