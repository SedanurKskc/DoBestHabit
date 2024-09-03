import 'package:cloud_firestore/cloud_firestore.dart';

class HabitsModel {
  String? id;
  String? habit;
  String category;
  DateTime? date;
  int? timeHour;
  int? timeMinute;
  bool? isCompleted; // Tamamlanma durumu ekleniyor

  HabitsModel({
    this.id,
    required this.habit,
    required this.category,
    required this.date,
     required this.timeHour,
     required this.timeMinute,
    this.isCompleted = false, // Varsayılan değer olarak false
  });

  // Firestore'dan veri almak için
  factory HabitsModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return HabitsModel(
      id: doc.id,
      habit: data['habit'] ?? '',
      category: data['category'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      timeHour: data['timeHour'] ?? 0,
      timeMinute: data['timeMinute'] ?? 0,
        isCompleted: data['isCompleted'] ?? false, // Varsayılan değer olarak false
    );
  }


  // Firestore'a veri göndermek için
  Map<String, dynamic> toMap() {
    return {
      'habit': habit,
      'category': category,
      'date': date!=null? Timestamp.fromDate(date!):null,
      'timeHour': timeHour,
      'timeMinute': timeMinute,
      'isCompleted': isCompleted??false, // Tamamlanma durumu ekleniyor
    };
  }
}
