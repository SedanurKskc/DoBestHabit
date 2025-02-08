class Book {
  final String title;
  final String coverId;
  final String author;
  final String description;

  Book({
    required this.title,
    required this.coverId,
    required this.author,
    required this.description,
  });

  String get coverUrl => 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No title',
      coverId: json['cover_i']?.toString() ?? '',
      author: (json['author_name'] as List<dynamic>?)?.isNotEmpty ?? false 
                ? (json['author_name'] as List<dynamic>).first 
                : 'Unknown',
      description: (json['first_sentence'] as List<dynamic>?)?.isNotEmpty ?? false
                ? (json['first_sentence'] as List<dynamic>).first.toString()
                : 'No description available',
    );
  }
}
