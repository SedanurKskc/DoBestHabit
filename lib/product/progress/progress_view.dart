import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/view/base_view.dart';
import '../../core/component/bottombar/bottombar.dart';
import '../habits/widgets/checkedHabits_provider.dart';
import 'progress_viewmodel.dart';
import 'widgets/pie_chart.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({
    Key? key,
  }) : super(key: key);
  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends ProgressViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const CivcivAppBar(
        title: "İlerleme",
      ),
      bottomNavigationBar: CustomBottomBar(),
      body: Consumer<CheckedHabitsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: paddings.h(sizes.s10) + paddings.v(sizes.s20),
              child: Column(
                children: [
              PieChartWidget(
                    completedPercentage: completedDailyPercentage,
                    uncompletedPercentage: uncompletedDailyPercentage,
                    category: "Günlük",
                  ),
                  PieChartWidget(
                    completedPercentage: completedWeeklyPercentage,
                    uncompletedPercentage: uncompletedWeeklyPercentage,
                    category: "Haftalık",
                  ),
                  PieChartWidget(
                    completedPercentage: completedMonthlyPercentage,
                    uncompletedPercentage: uncompletedMonthlyPercentage,
                    category: "Aylık",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
