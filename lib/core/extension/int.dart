import 'package:intl/intl.dart';

extension IntExtension on int {
  String get thousandSeperator {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, '.');
      index -= 3;
    }
    return numberDigits.join();
  }

  String get moneyString => '$thousandSeperator,00 \$';

  int get commission => ((this < 100) ? 0 : this * 5 ~/ 100);
  int get commissionWithMoney => this + commission;
  String get commissionWithMoneyString => commissionWithMoney.moneyString;

  String get monthDate => DateFormat('MMMM', 'tr_TR').format(DateTime(2024, this));
}
