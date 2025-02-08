import 'package:dobesthabit/core/base/state/base_state.dart';
import 'package:dobesthabit/core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import '../../modules/book/book_model.dart';
import '../../modules/book/book_service.dart';

class BookListPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CivcivAppBar(
        title: "Kitaplar",
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Hata: ${snapshot.error}',
              style: TextStyle(color: Colors.black),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Sonuç bulunamadı.'));
          } else {
            final books = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    margin: paddings.b(sizes.s20),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (book.coverId.isNotEmpty)
                            Image.network(
                              book.coverUrl,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            )
                          else
                            Placeholder(fallbackHeight: 150),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              book.title,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Yazar: ${book.author}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book.description,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
