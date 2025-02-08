import 'package:flutter/material.dart';

import '../../modules/firebase/firebase.dart';
import '../../modules/gemini/gemini_service.dart';

class GeminiViewmodel extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final FirebaseService _firebaseService = FirebaseService();

  String _response = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> _firebaseData = [];
  List<Map<String, String>> _messages = []; 
  bool get isLoading => _isLoading;
  String get response => _response;
  List<Map<String, dynamic>> get firebaseData => _firebaseData;
  List<Map<String, String>> get messages => _messages;


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
    if (query.isNotEmpty) {
      // Kullanıcının mesajını hemen ekle
      if (!_messages.any((msg) => msg.containsValue(query))) {
        _messages.add({'user': query});
        notifyListeners(); // Mesajı hemen göstermek için
      }
    }

    _isLoading = true;
    notifyListeners(); 

    try {
      if (query.toLowerCase().contains('alışkanlık öner')) {
        await fetchRecommendations('habits', query);
      } else {
        final response = await _geminiService.getGeminiResponse(query);
        if (response != 'Yanıt bulunamadı') {
          _messages.add({'gemini': response});
        } else {
          _messages.add({'gemini': 'Yanıt bulunamadı. Lütfen tekrar deneyin.'});
        }
      }
    } catch (e) {
      _messages.add({'gemini': 'Bir hata oluştu: $e'});
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchAndQuery(String collection, String query) async {
    await fetchFirebaseData(collection);
    await fetchGeminiResponse(query);
  }
  Future<void> fetchRecommendations(String collection, String query) async {
    await fetchFirebaseData(collection);
    String generatedQuery = _generateQueryFromFirebaseData(_firebaseData);
    final response = await _geminiService.getGeminiResponse(generatedQuery);

    if (!_messages.any((msg) => msg.containsValue(query))) {
      _messages.add({'user': query});
    }
    _messages.add({'gemini': response});
    notifyListeners();
  }

  String _generateQueryFromFirebaseData(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return "Veritabanında hiç alışkanlık bulunamadı.";
    }
    final habits = data.map((item) => item['habit'] ?? 'No habit').toList();
    return "Bana bu alışkanlıklara benzer yeni alışkanlıklar öner: ${habits.join(', ')}.";
  }
}
