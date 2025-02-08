import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dobesthabit/core/base/state/base_state.dart';
import 'package:flutter/material.dart';
import '../../core/base/view/base_view.dart';
import 'motivation_viewmodel.dart';

class MotivationView extends StatefulWidget {
  const MotivationView({super.key});

  @override
  State<MotivationView> createState() => _MotivationViewState();
}

class _MotivationViewState extends BaseState<MotivationView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: CivcivAppBar(
          title: "Motivasyon 💬",
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("motivation").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Bir hata oluştu : ${snapshot.error}"),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("Hiç veri bulunamadı!"),
                );
              }
              var documents = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var data = documents[index].data() as Map<String, dynamic>;
                    return Container(
                      padding: paddings.a(sizes.s8),
                      margin: paddings.h(sizes.s20) + paddings.v(sizes.s10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(sizes.s8), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]),
                      child: Row(
                        children: [
                          if (data['imageUrl'] != null)
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(data['imageUrl']),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.justify,
                                    data['quote'],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8), 
                                  Text(
                                    data['author'],
                                    style: const TextStyle(fontSize: 14, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
