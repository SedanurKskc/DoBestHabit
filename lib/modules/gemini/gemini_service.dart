import 'package:dio/dio.dart';

class GeminiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent'; // Güncellenmiş API endpoint URL'si
  final String _apikey = 'AIzaSyDlb_OqjXu34ohOCvWQVnXfqJo7-HL63k8'; // Gerçek API Key'inizi buraya ekleyin

 Future<String> getGeminiResponse(String query) async {
  try {
    final response = await _dio.post(
      '$_baseUrl?key=$_apikey',
      data: {
        'contents': [
          {
            'parts': [
              {'text': query}
            ]
          }
        ]
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      // Yanıtın yapısını kontrol edin
      print('Response Data: ${response.data}');
      
      // Yanıtın doğru yapıya sahip olduğundan emin olun
      final data = response.data as Map<String, dynamic>;
      final candidates = data['candidates'] as List<dynamic>;
      
      if (candidates.isNotEmpty) {
        final firstCandidate = candidates.first as Map<String, dynamic>;
        final content = firstCandidate['content'] as Map<String, dynamic>;
        final parts = content['parts'] as List<dynamic>;
        
        if (parts.isNotEmpty) {
          final firstPart = parts.first as Map<String, dynamic>;
          return firstPart['text'] ?? 'Yanıt bulunamadı';
        }
      }
      
      return 'Yanıt bulunamadı';
    } else {
      print('API Error: ${response.statusCode}');
      return 'API Error: ${response.statusCode}';
    }
  } catch (e) {
    print('Error: $e');
    return 'Bir hata oluştu: $e';
  }
}


}
