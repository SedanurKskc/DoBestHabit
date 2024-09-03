import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../modules/habits/habits_model.dart'; // Veri sağlayıcılarınıza göre değiştirin

class HabitsViewmodel extends ChangeNotifier {
  late Future<void> initFuture;
  List<HabitsModel> dailyHabits = [];
  List<HabitsModel> weeklyHabits = [];
  List<HabitsModel> monthlyHabits = [];

  HabitsViewmodel() {
    initFuture = initialize();
  }

  Future<void> initialize() async {
    try {
      // Verileri çek ve listeye ekle
      dailyHabits = await fetchDailyHabits();
      weeklyHabits = await fetchWeeklyHabits();
      monthlyHabits = await fetchMonthlyHabits();
      notifyListeners(); // Veriler güncellendiğinde UI'ı bilgilendirin
    } catch (e) {
      print('Initialization error: $e');
    }
  }

  Future<List<HabitsModel>> fetchDailyHabits() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('habits').where('category', isEqualTo: 'Günlük').get();

      return querySnapshot.docs.map((doc) => HabitsModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching daily habits: $e');
      return [];
    }
  }

  Future<List<HabitsModel>> fetchWeeklyHabits() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('habits').where('category', isEqualTo: 'Haftalık').get();

      return querySnapshot.docs.map((doc) => HabitsModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching weekly habits: $e');
      return [];
    }
  }

  Future<List<HabitsModel>> fetchMonthlyHabits() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('habits').where('category', isEqualTo: 'Aylık').get();

      return querySnapshot.docs.map((doc) => HabitsModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching monthly habits: $e');
      return [];
    }
  }
}
