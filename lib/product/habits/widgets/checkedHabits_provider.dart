import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CheckedHabitsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;

  Map<String, Map<int, bool>> _checkedHabits = {};

  CheckedHabitsProvider() {
    _loadCheckedHabits();
  }
Future<void> _loadCheckedHabits() async {
  try {
    // Firestore'dan tüm belgeleri almak
    QuerySnapshot snapshot = await _firestore.collection('checkedHabits').get();
    Map<String, Map<int, bool>> habits = {};
    for (var doc in snapshot.docs) {
      String category = doc.id;
      // Firestore'dan alınan veriyi Map<String, dynamic> olarak alıyoruz
      Map<int, bool> habitMap = {};
      (doc.data() as Map<String, dynamic>).forEach((key, value) {
        // Key'i String'den int'e çeviriyoruz
        habitMap[int.parse(key)] = value as bool;
      });
      habits[category] = habitMap;
    }
    _checkedHabits = habits;
  } catch (e) {
    // Hata yönetimi
    print('Error loading checked habits: $e');
  } finally {
    _isLoading = false; // Yükleme tamamlandı
    notifyListeners();
  }
}


  Map<String, Map<int, bool>> get checkedHabits => _checkedHabits;
  bool get isLoading => _isLoading;

  bool isChecked(String category, int index) {
    return _checkedHabits[category]?[index] ?? false;
  }

  Future<void> toggleCheck(String category, int index) async {
    _checkedHabits[category] ??= {};
    // Alışkanlığın mevcut durumunu al
    bool currentValue = _checkedHabits[category]?[index] ?? false;
    // Yeni değeri hesapla (tersini al)
    bool newValue = !currentValue;
    
    // Haritayı güncelle
    _checkedHabits[category]![index] = newValue;

// UI'yı hemen güncelle
  notifyListeners();
    try {
      // Firestore'da güncelleme yap
      await _firestore.collection('checkedHabits').doc(category).set(_checkedHabits[category]!.map((key, value) => MapEntry(key.toString(), value)));
     
    } catch (e) {
      // Hata yönetimi
      print('Error updating checked habits: $e');
    }
  }
  void calculateCompletionPercentage() {
    // Yüzdeleri hesaplamak için gerekli kodu buraya ekleyin
    notifyListeners(); // UI'yı güncellemek için
  }
}
