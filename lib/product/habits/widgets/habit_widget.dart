import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dobesthabit/modules/habits/habits_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../../core/base/state/base_state.dart';
import '../../../modules/habits/habits_manager.dart';
import 'checkedHabits_provider.dart';

class HabitListView extends StatefulWidget {
  final String category;

  HabitListView({
    required this.category,
  });
  @override
  State<HabitListView> createState() => _HabitListViewState();
}

class _HabitListViewState extends BaseState<HabitListView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HabitsModel>>(
      initialData: [], // Başlangıçta boş liste döndür
      stream: _streamHabits(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Hiç alışkanlık yok'));
        }
        final habits = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final date = habit.date;
                  final formattedDate = date != null ? DateFormat('dd MMMM yyyy EEEE', 'tr_TR').format(date) : '';
                  final formattedTime = (habit.timeHour != null && habit.timeMinute != null) ? '${habit.timeHour.toString().padLeft(2, '0')}:${habit.timeMinute.toString().padLeft(2, '0')}' : '';

                  // Alışkanlığın tik durumunu provider'dan al
                  final isChecked = context.watch<CheckedHabitsProvider>().isChecked(widget.category, index);

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(habit.habit ?? "", style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface)),
                                SizedBox(height: 4.0),
                                Text(formattedDate, style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface)),
                                SizedBox(height: 4.0),
                                Text(formattedTime, style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Tikleme işlemi için provider'ı kullan
                                    context.read<CheckedHabitsProvider>().toggleCheck(widget.category, index);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(isChecked ? Icons.check : null, color: colorScheme.onSurface),
                                ),
                              ),
                              SizedBox(height: sizes.s10),
                              InkWell(
                                onTap: () {
                                  context.read<HabitsModelManager>().deleteHabit(habit.id); // Silme işlemi
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Firestore'dan veri akışını sağlayan Stream
  Stream<List<HabitsModel>> _streamHabits(String category) {
    return FirebaseFirestore.instance.collection('habits').where('category', isEqualTo: category).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Debug: Verileri kontrol edin
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
        return HabitsModel.fromFirestore(doc);
      }).toList();
    });
  }
}
