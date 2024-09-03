import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/base/state/base_state.dart';
import '../../../core/component/field/text.dart';
import '../../../modules/habits/habits_model.dart';
import 'calender.dart';
import 'timePicker.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends BaseState<CustomDialog> {
  final TextEditingController _addHabitController = TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();
  final List<String> _options = ['Günlük', 'Haftalık', 'Aylık'];
  bool _showDropdown = false;
  DateTime selectedDate = DateTime.now();
  int selectedHour = 0;
  int selectedMinute = 0;

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }
  void onMinuteSelected(int minute) {
    setState(() {
      selectedMinute = minute;
    });
  }
  void onHourSelected(int hour) {
    setState(() {
      selectedHour = hour;
    });
  }

  void _addHabit() {
    final newHabit = _addHabitController.text;
    final category = _dropdownController.text;

    if (newHabit.isNotEmpty && category.isNotEmpty) {
       // Firestore için UID oluşturma
    final String uid = FirebaseFirestore.instance.collection('habits').doc().id;
      final habit = HabitsModel(
        habit: newHabit,
        category: category,
        date: selectedDate,
        timeHour: selectedHour,
        timeMinute: selectedMinute,
      );
    // Kategoriye göre Firestore ekleme (isteğe bağlı)
     FirebaseFirestore.instance.collection('habits').add(habit.toMap());
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Hata",
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.error),
          ),
          content: Text(
            "Lütfen bir alışkanlık ve kategori seçiniz.",
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Tamam",
                style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: deviceWidth / 10,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(sizes.s10)),
        ),
        child: Center(
          child: Text(
            "Alışkanlık Ekle",
            style: textTheme.headlineSmall!.copyWith(color: colorScheme.onSurface),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          margin: paddings.t(sizes.s20),
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomField(
                controller: _addHabitController,
                hintText: "Alışkanlık ",
              ),
              SizedBox(
                height: deviceWidth / 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showDropdown = !_showDropdown;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 5, color: Colors.black.withOpacity(0.2))],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dropdownController.text.isEmpty ? "Bir aralık seç" : _dropdownController.text,
                          style: textTheme.labelSmall!.copyWith(
                            color: _dropdownController.text.isEmpty ? Colors.grey : colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              if (_showDropdown)
                Column(
                  children: _options.map((String value) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _dropdownController.text = value;
                          _showDropdown = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 5, color: Colors.black.withOpacity(0.2))],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                value,
                                style: textTheme.labelSmall!.copyWith(color: colorScheme.onSurface),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(
                height: deviceWidth / 20,
              ),
              CalendarItem(
                date: DateTime.now(),
                onDateSelected: onDateSelected,
              ),
              CustomTimePicker(
                selectedHour: selectedHour,
                selectedMinute: selectedMinute,
                onHourSelected: onHourSelected,
                onMinuteSelected: onMinuteSelected,
              ),
              Text(
                "Seçilen Tarih ve Saat: ${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year} ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}",
                style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addHabit,
          child: Text("Ekle"),
        ),
      ],
    );
  }
}
