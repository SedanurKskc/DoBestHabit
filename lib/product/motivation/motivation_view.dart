import 'package:flutter/material.dart';import '../../core/base/view/base_view.dart';
import 'motivation_viewmodel.dart';

class MotivationView extends StatefulWidget {
const MotivationView({super.key});
@override
State<MotivationView> createState() => _MotivationViewState();
}
class _MotivationViewState extends MotivationViewmodel {
@override
Widget build(BuildContext context) {
return const BaseView();
}
}