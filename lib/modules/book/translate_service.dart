import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translateToTurkish(String text) async {
  final response = await http.post(
    Uri.parse('https://libretranslate.com/translate'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'q': text,
      'source': 'en',
      'target': 'tr',
      'format': 'text',
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['translatedText'];
  } else {
    throw Exception('Çeviri işlemi başarısız oldu.');
  }
}
