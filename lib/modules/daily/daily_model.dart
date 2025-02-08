import 'package:cloud_firestore/cloud_firestore.dart';

class DailyModel {
   String? id;
   String content;
  DateTime timeStamp;

  DailyModel({this.id, required this.content, required this.timeStamp});
  factory DailyModel.fromMap(Map<String, dynamic> data,String id) {
    return DailyModel(
      id:id,
      content: data['content'] ?? '',
      timeStamp: (data['timeStamp'] as Timestamp).toDate(), // 
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timeStamp': Timestamp.fromDate(timeStamp),
    };
  }
}
