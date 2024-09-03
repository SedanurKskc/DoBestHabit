import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dobesthabit/modules/habits/habits_model.dart';

class HabitsModelManager extends ChangeNotifier {
  List<HabitsModel> dailyHabits = [];
  List<HabitsModel> weeklyHabits = [];
  List<HabitsModel> monthlyHabits = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addHabit(HabitsModel habit, String uid) async {
    habit.id = uid;
    if (habit.category == 'Günlük') {
      dailyHabits.add(habit);
    } else if (habit.category == 'Haftalık') {
      weeklyHabits.add(habit);
    } else if (habit.category == 'Aylık') {
      monthlyHabits.add(habit);
    }
    // Listeyi güncelle
    await fetchHabits();
    // Firestore'a ekleme
    await _firestore.collection('habits').doc(habit.id).set(habit.toMap());
  }

  void updateHabitCompletionStatus(String id, bool isCompleted) async {
    try {
      await _firestore.collection('habits').doc(id).update({'isCompleted': isCompleted});
      // Listeyi güncelle
      await fetchHabits();
    } catch (e) {
      print('Güncelleme işlemi sırasında bir hata oluştu: $e');
    }
  }

  void deleteHabit(String? id) async {
    try {
      if (id != null && id.isNotEmpty) {
        await _firestore.collection('habits').doc(id).delete();
        // Listeyi güncelle
        await fetchHabits();
      } else {
        print('Geçersiz id: id boş veya null.');
      }
    } catch (e) {
      print('Silme işlemi sırasında bir hata oluştu: $e');
    }
  }

  Future<void>fetchHabits() async {
    try {
      final snapshot = await _firestore.collection('habits').get();
      final List<HabitsModel> allHabits = snapshot.docs.map((doc) => HabitsModel.fromFirestore(doc)).toList();

      dailyHabits = allHabits.where((habit) => habit.category == 'Günlük').toList();
      weeklyHabits = allHabits.where((habit) => habit.category == 'Haftalık').toList();
      monthlyHabits = allHabits.where((habit) => habit.category == 'Aylık').toList();

      notifyListeners();
    } catch (e) {
      print('Veri çekme işlemi sırasında bir hata oluştu: $e');
    }
  }
}
