import 'package:flutter/material.dart';
import '../../base/state/base_state.dart';

class AppTabbar extends StatefulWidget {
  final String firstTitle;
  final String secondTitle;
  final String thirdTitle;
  const AppTabbar({super.key, required this.firstTitle, required this.secondTitle, required this.thirdTitle});

  @override
  State<AppTabbar> createState() => _AppTabbarState();
}

class _AppTabbarState extends BaseState<AppTabbar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings.a(sizes.s20) - paddings.b(sizes.s20),
      child: Container(
        width: 350,
        height: sizes.s32,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Padding(
          padding: paddings.a(sizes.s4 / 2),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.circular(9.0)),
            labelColor: colorScheme.background,
            tabs: [
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.firstTitle,
                      style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.secondTitle,
                      style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.thirdTitle,
                      style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
