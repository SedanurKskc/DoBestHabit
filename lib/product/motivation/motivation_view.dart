import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/view/base_view.dart';
import 'motivation_viewmodel.dart';
import 'notification_service.dart';

class MotivationView extends StatefulWidget {
  const MotivationView({super.key});

  @override
  State<MotivationView> createState() => _MotivationViewState();
}

class _MotivationViewState extends MotivationViewmodel {
  @override
  Widget build(BuildContext context) {
  

    return BaseView(
      appBar: const CivcivAppBar(
        title: "Motivasyon",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
               
              },
              child: const Text("Bildirim Gönder"),
            ),
          ],
        ),
      ),
    );
  }
}
