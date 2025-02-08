import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dobesthabit/core/base/state/base_state.dart';
import 'package:dobesthabit/core/component/field/text.dart';
import 'package:dobesthabit/modules/daily/daily_model.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final DailyModel? dailyEntry;
  const CustomDialog({super.key, this.dailyEntry});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends BaseState<CustomDialog> {
  late TextEditingController _contentController;
  DateTime timeStamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.dailyEntry?.content ?? '');
  }

  void _addOrUpdateDaily() {
    final newDaily = _contentController.text;
    if (newDaily.isNotEmpty) {
      final daily = DailyModel(content: _contentController.text, timeStamp: timeStamp);
      if (widget.dailyEntry == null) {
        // Yeni günlük ekle
        FirebaseFirestore.instance.collection("daily").add(daily.toMap());
        Navigator.of(context).pop();
      } else {
        // Mevcut günlük güncelle
        FirebaseFirestore.instance.collection("daily").doc(widget.dailyEntry!.id).update(daily.toMap());
        Navigator.of(context).pop();
        _contentController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
          child: Container(
        margin: paddings.t(sizes.s20),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: deviceHeight / 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(textAlign: TextAlign.left, "Günlük Yaz", style: textTheme.bodyMedium!.copyWith(color: Colors.black)),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.grey),
                      controller: _contentController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: "Günlük içeriğinizi yazın...",
                      ),
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceWidth / 20,
            ),
            TextButton(
              onPressed: () {
                _addOrUpdateDaily();
              },
              child: Text(widget.dailyEntry == null ? "Ekle" : "Güncelle"),
            ),
          ],
        ),
      )),
    );
  }
}
