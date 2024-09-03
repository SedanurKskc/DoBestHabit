// ignore_for_file: require_enabled_experimental_language_features

import 'package:dobesthabit/product/gemini/gemini_view.dart';
import 'package:flutter/material.dart';


import '../../../product/home/home_view.dart';
import '../../base/util/color.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key); // Key parametresi düzgün kullanımı

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final List<Map<String, dynamic>> icons = [
    {"title": "Home", "icon": Icons.home, "widget": HomeView()},
    {"title": "AI", "icon": Icons.chat, "widget": GeminiView()},
    {"title": "Profil", "icon": Icons.person, "widget": Container()},
  ];

  int selectedIndex = 0;

  void _onTapItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => icons[index]["widget"]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight * 1.7,
      decoration: BoxDecoration(
        color: ColorUtility.background,
      ),
      child: Row(
        children: icons.asMap().entries.map((entry) {
          int idx = entry.key;
          String title = entry.value["title"];
          IconData icon = entry.value["icon"];
          return _barItem(title, icon, idx);
        }).toList(),
      ),
    );
  }

  Widget _barItem(String title, IconData icon, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTapItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? ColorUtility.primary : ColorUtility.onPrimary.withOpacity(0.6),
              size: 45,
            ),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? ColorUtility.primary : ColorUtility.onPrimary.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
