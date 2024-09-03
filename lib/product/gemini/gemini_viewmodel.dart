import 'package:flutter/material.dart';

import '../../modules/firebase/fireabase.dart';
import '../../modules/gemini/gemini_service.dart';

class GeminiViewmodel extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final FirebaseService _firebaseService = FirebaseService();

  String _response = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> _firebaseData = []; // Firebase'den alınan verileri tutar
  List<Map<String, String>> _messages = []; // Kullanıcı ve API mesajlarını tutar

  // Getter metodları
  bool get isLoading => _isLoading;
  String get response => _response;
  List<Map<String, dynamic>> get firebaseData => _firebaseData;
  List<Map<String, String>> get messages => _messages;

  // Firebase'den veri çeken metod
  Future<void> fetchFirebaseData(String collection) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _firebaseService.getData(collection);
      if (data.isNotEmpty) {
        _firebaseData = data.map((item) {
          return {
            'habit': item['habit'] ?? 'No habit',
            'category': item['category'] ?? 'No category',
          };
        }).toList();
        print('Fetched Firebase Data: $_firebaseData');
      } else {
        print('No data found in Firebase');
      }
    } catch (e) {
      print('Error fetching Firebase data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

Future<void> fetchGeminiResponse(String query) async {
  _isLoading = true;
  notifyListeners();

  try {
    final response = await _geminiService.getGeminiResponse(query);
    
    // Kullanıcının mesajını ekle
    _messages.add({'user': query});
    
    // Yanıtı kontrol edip ekle
    if (response != 'Yanıt bulunamadı') {
      _messages.add({'gemini': response});
    } else {
      _messages.add({'gemini': 'Yanıt bulunamadı. Lütfen tekrar deneyin.'});
    }
  } catch (e) {
    _messages.add({'gemini': 'Bir hata oluştu: $e'});
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}



  // Firebase'den veri çekip ardından Gemini API'ye sorgu gönderen fonksiyon
  Future<void> fetchAndQuery(String collection, String query) async {
    await fetchFirebaseData(collection); // Firebase'den veriyi çeker
    await fetchGeminiResponse(query); // Gemini API'ye sorgu gönderir
  }


Future<void> fetchRecommendations(String collection, String query) async {
  await fetchFirebaseData(collection);

  // Firebase'den alınan verilere göre sorgu oluştur (artık query parametresini kullanmıyor)
  String generatedQuery = _generateQueryFromFirebaseData(_firebaseData);

  // Öneri için sorguyu Gemini API'ye gönder
  final response = await _geminiService.getGeminiResponse(generatedQuery);

  // Kullanıcı mesajını ve öneriyi ekle
  _messages.add({'user': query});
  _messages.add({'gemini': response});
}




// Firebase'den alınan verilere dayalı sorgu oluşturma (ekranda göstermeden arka planda kullanma)
String _generateQueryFromFirebaseData(List<Map<String, dynamic>> data) {
  final habits = data.map((item) => item['habit'] ?? 'No habit').toList();
  
  // Kullanıcıdan ek bilgi istemeyen bir sorgu oluştur
  return "Bana yeni alışkanlıklar öner.";
}


}
