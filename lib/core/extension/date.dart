import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  DateTime get onlyDate => DateTime(year, month, day, 0, 0, 0);
  bool isSameDay(DateTime date) => onlyDate == date.onlyDate;
  String get monthDate => DateFormat('EEEE', 'tr_TR').format(onlyDate);
  String get formattedDate => DateFormat('dd MMMM yyyy EEEE', 'tr_TR').format(onlyDate);
  String get headerDate => DateFormat('MMMM yyyy', 'tr_TR').format(onlyDate);
  String get serverDate => DateFormat('yyyy-MM-dd', 'tr_TR').format(onlyDate);
}
