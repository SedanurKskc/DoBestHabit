
import 'package:provider/provider.dart';
import '../../core/base/state/base_state.dart';
import '../habits/widgets/checkedHabits_provider.dart';
import 'progress_view.dart';

abstract class ProgressViewmodel extends BaseState<ProgressView> {
  
  double _calculatePercentage(String category, bool isCompleted) {
    final checkedHabits = context.watch<CheckedHabitsProvider>().checkedHabits[category] ?? {};
    final total = checkedHabits.length;
    if (total == 0) return 0;
    final count = checkedHabits.values.where((checked) => checked == isCompleted).length;
    return (count / total) * 100;
  }

  double get completedDailyPercentage => _calculatePercentage("Günlük", true);
  double get uncompletedDailyPercentage => _calculatePercentage("Günlük", false);
  double get completedWeeklyPercentage => _calculatePercentage("Haftalık", true);
  double get uncompletedWeeklyPercentage => _calculatePercentage("Haftalık", false);
  double get completedMonthlyPercentage => _calculatePercentage("Aylık", true);
  double get uncompletedMonthlyPercentage => _calculatePercentage("Aylık", false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
