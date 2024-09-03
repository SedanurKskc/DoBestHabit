import 'package:flutter/material.dart';



import 'package:provider/provider.dart';
import '../../civciv/appbar.dart';
import '../../core/base/state/base_state.dart';
import '../../modules/habits/habits_manager.dart';
import 'habits_viewmodel.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/habit_widget.dart';

class HabitsView extends StatefulWidget {
  @override
  _HabitsViewState createState() => _HabitsViewState();
}

class _HabitsViewState extends BaseState<HabitsView> {
  late HabitsViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = Provider.of<HabitsViewmodel>(context, listen: false);
   // viewmodel.initialize(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitsModelManager>(
      builder: (context, habitsManager, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: CivcivAppBar(
              title: 'Alışkanlıklar',
              customRightIcon: IconButton(
                icon: Icon(Icons.add, color: colorScheme.onSurface),
                onPressed: () {
                  showDialog(
                    barrierDismissible: true, // Dialog dışına tıklanarak kapanmasını sağlar
                    context: context,
                    builder: (context) => CustomDialog(),
                  );
                },
              ),
              bottom: const TabBar(
                indicatorColor: Colors.cyan,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.grey,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "Günlük"),
                  Tab(text: "Haftalık"),
                  Tab(text: "Aylık"),
                ],
              ),
            ),
            body: FutureBuilder<void>(
             future: viewmodel.initFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata oluştu: ${snapshot.error}'));
                } else {
                  return TabBarView(
                    children: [
                      HabitListView( category: 'Günlük'),
                      HabitListView(category: 'Haftalık'),
                      HabitListView(category: 'Aylık'),
                    ],
                  );
                }
              },
            ), 
          ),
        );
      },
    );
  }
}
