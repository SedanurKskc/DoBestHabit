import 'dart:convert';
import 'package:http/http.dart' as http;

import 'book_model.dart';

Future<List<Book>> fetchBooks(int page) async {
  try {
    final response = await http.get(
      Uri.parse('https://openlibrary.org/search.json?q=classic&page=$page&limit=10'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); 
      final List<dynamic> docs = data['docs'] ?? [];
      return docs
          .where((doc) => doc['cover_i'] != null && (doc['description'] != null || doc['first_sentence'] != null))
          .map((doc) => Book.fromJson(doc))
          .toList();
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch books');
  }
}
