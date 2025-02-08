import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotivationService {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("motivation");

  Future<Map<String,String>> getRandomMotivationQuote() async {
    QuerySnapshot snapshot = await _collectionReference.get(); 
    if (snapshot.docs.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(snapshot.docs.length);
      var selectedData = snapshot.docs[randomIndex];
      String quote = (selectedData['quote']??"").toString();
      String author = (selectedData['author']??"").toString();
      return {'quote': quote, 'author': author};
    }
    else {
       return {'quote': 'No quotes available', 'author': 'Unknown'}; 
    }
  }
}
