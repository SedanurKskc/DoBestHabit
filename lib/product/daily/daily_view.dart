import 'package:dobesthabit/modules/daily/daily_model.dart';
import 'package:dobesthabit/product/daily/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/base/view/base_view.dart';
import '../../modules/daily/daily_manager.dart';
import 'daily_viewmodel.dart';

class DailyView extends StatefulWidget {
  const DailyView({super.key});
  @override
  State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends DailyViewmodel {
  final DailyManager _dailyManager = DailyManager();
  String formatTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: CivcivAppBar(
        title: "Günlüğüm",
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
      ),
      body: StreamBuilder<List<DailyModel>>(
        stream: getDailys(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Hata oluştu: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Henüz günlük girişiniz bulunmamaktadır."),
            );
          }
          final dailys = snapshot.data!;
          return ListView.builder(
              itemCount: dailys.length,
              itemBuilder: (context, index) {
                final dailyEntry = dailys[index];
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
                  child: ListTile(
                    title: Text(
                      dailyEntry.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(formatTime(dailyEntry.timeStamp)),
                    onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(dailyEntry: dailyEntry),
                    );
                  },
                    trailing: InkWell(
                      onTap: () => _dailyManager.deleteDaily(dailyEntry.id),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Icon(
                            Icons.close,
                            color: colorScheme.error,
                          )),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
