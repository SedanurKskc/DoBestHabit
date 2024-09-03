import 'package:flutter/material.dart';

import '../../../core/base/state/base_state.dart';



class CustomTimePicker extends StatefulWidget {
  final int selectedHour;
  final int selectedMinute;
  final ValueChanged<int> onHourSelected;
  final ValueChanged<int> onMinuteSelected;

  const CustomTimePicker({Key? key, required this.selectedHour, required this.selectedMinute, required this.onHourSelected, required this.onMinuteSelected});
  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends BaseState<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.selectedHour;
    selectedMinute = widget.selectedMinute;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle dropdownTextStyle = textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<int>(
              style: dropdownTextStyle,
              value: selectedHour,
              items: List.generate(24, (index) => index)
                  .map((hour) => DropdownMenuItem(
                        value: hour,
                        child: Text(hour.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedHour = value!;
                  widget.onHourSelected(value); // Saat seçildiğinde geri bildirim gönder
                });
              },
            ),
            SizedBox(width: 8),
            Text(':', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            DropdownButton<int>(
              style: dropdownTextStyle,
              value: selectedMinute,
              items: List.generate(60, (index) => index)
                  .map((minute) => DropdownMenuItem(
                        value: minute,
                        child: Text(minute.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMinute = value!;
                  widget.onMinuteSelected(value);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
