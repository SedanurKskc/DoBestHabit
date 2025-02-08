import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DailyManager extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> deleteDaily(String? id) async {
    try {
      if (id != null && id.isNotEmpty) {
        await _firebaseFirestore.collection("daily").doc(id).delete();
        print("Günlük başarıyla silindi: $id");
      } else {
        print('Geçersiz id: id boş veya null.');
      }
    } catch (e) {
      print('Silme işlemi sırasında bir hata oluştu: $e');
    }
  }
}




