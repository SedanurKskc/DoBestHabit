import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import '../../../core/base/state/base_state.dart';

class CalendarItem extends StatefulWidget {
  final DateTime date;
  final bool clickable;
  final Function(DateTime date) onDateSelected;

  const CalendarItem({
    Key? key,
    required this.date,
    required this.onDateSelected,
    this.clickable = true,
  }) : super(key: key);

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends BaseState<CalendarItem> {
  DateTime selectedDate = DateTime.now();
  DateTime targetDate = DateTime.now();
  
  onSelect(DateTime p0) async {
    if (widget.clickable) setState(() => this.selectedDate = p0);
    await widget.onDateSelected(p0);
    print("onSelect çağrıldı: $p0");
  }

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      maxSelectedDate: DateTime(widget.date.year + 3, widget.date.month, widget.date.day),
      selectedDateTime: selectedDate,
      selectedDayTextStyle: textTheme.titleLarge!.copyWith(color: colorScheme.surface),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.transparent,
      selectedDayButtonColor: colorScheme.primary,
      selectedDayBorderColor: Colors.transparent,
      customGridViewPhysics: const BouncingScrollPhysics(),
      height: (320 / 932) * deviceHeight,
      headerMargin: EdgeInsets.zero,
      headerTitleTouchable: false,
      isScrollable: true,
      headerTextStyle: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
      weekdayTextStyle: textTheme.bodySmall!.copyWith(color: colorScheme.onPrimary),
      todayTextStyle: textTheme.titleMedium!.copyWith(color: colorScheme.error),
      weekendTextStyle: textTheme.titleMedium!.copyWith(color: colorScheme.onSecondary),
      daysTextStyle: textTheme.titleMedium!.copyWith(color: colorScheme.onSurface),
      onDayPressed: (p0, p1) => onSelect(p0),
      showHeaderButton: true,
      headerText: DateFormat.yMMM('tr_TR').format(targetDate),
      showOnlyCurrentMonthDate: false,
      weekDayFormat: WeekdayFormat.short,
      locale: "tr",
      firstDayOfWeek: 1,
      thisMonthDayBorderColor: Colors.transparent,
      showWeekDays: true,
      weekFormat: false,
      daysHaveCircularBorder: true,
      targetDateTime: targetDate,
      onCalendarChanged: (DateTime date) {
        setState(() {
          targetDate = date;
        });
      },
    );
  }
}
