import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../core/base/state/base_state.dart';

class PieChartWidget extends StatefulWidget {
  final double completedPercentage;
  final double uncompletedPercentage;
  final String category;
  const PieChartWidget({super.key, required this.completedPercentage, required this.uncompletedPercentage, required this.category});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends BaseState<PieChartWidget> {

  @override
  Widget build(BuildContext context) {
     // dataMap her build çağrısında güncelleniyor.
    final dataMap = {
      "Tamamlanan": widget.completedPercentage,
      "Tamamlanmayan": widget.uncompletedPercentage,
    };
    return Padding(
      padding: paddings.a(sizes.s10),
      child: Container(
        padding: paddings.a(sizes.s20),
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(sizes.s20), boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 5, color: Colors.black.withOpacity(0.2))]),
        child: PieChart(
          centerWidget: Text(
            widget.category,
            style: textTheme.headlineMedium!.copyWith(color: colorScheme.onSurface),
          ),
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 800),
          chartType: ChartType.ring,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          colorList: [
            colorScheme.onPrimary,
            colorScheme.tertiary,
          ],
          legendOptions: LegendOptions(showLegendsInRow: false, legendPosition: LegendPosition.right, legendTextStyle: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface)),
        ),
      ),
    );
  }
}
