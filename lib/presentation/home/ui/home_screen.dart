import 'package:flutter/material.dart';
import 'package:my_calendar/widgets/calendar_view/ui/lich_am_duong_mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LichAmDuongMobile(),
    );
  }
}
