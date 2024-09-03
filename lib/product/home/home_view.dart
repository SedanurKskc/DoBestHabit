import 'package:flutter/material.dart';


import '../../core/base/view/base_view.dart';
import '../../core/component/bottombar/bottombar.dart';
import '../../core/modules/navigate/manager.dart';
import 'home_viewmodel.dart';
import 'widgets/enum.dart';
import 'widgets/item.dart';

class HomeView extends StatefulWidget {
  final String name = "Seda";
  HomeView({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: paddings.b(sizes.s32) + paddings.h(sizes.s20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Merhaba ${widget.name},",
                style: textTheme.headlineMedium!.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2.2 / 3,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(sizes.s40), topRight: Radius.circular(sizes.s40)),
                ),
              ),
              Column(
                children: [
                  TypeItem(
                    onTap: () => NavigationManager.instance.nav(path: NavPath.habits),
                    type: ContainerSize.small,
                    title: "Alışkanlıklar",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TypeItem(
                        onTap: () => NavigationManager.instance.nav(path: NavPath.motivation),
                        title: "Motivasyon",
                        type: ContainerSize.medium,
                        imagePath: "assets/images/Motivation.png",
                      ),
                      TypeItem(
                        onTap: () => NavigationManager.instance.nav(path: NavPath.progress),
                        title: "İlerleme",
                        type: ContainerSize.medium,
                        imagePath: "assets/images/Statistics.png",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TypeItem(
                        onTap: () => NavigationManager.instance.nav(path: ""),
                        title: "Kişisel Gelişim",
                        type: ContainerSize.medium,
                        imagePath: "assets/images/personality.png",
                      ),
                      TypeItem(
                        onTap: () => NavigationManager.instance.nav(path: ""),
                        title: "Besin Değeri",
                        type: ContainerSize.medium,
                        imagePath: "assets/images/food.png",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
