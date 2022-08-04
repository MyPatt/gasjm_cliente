import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarioCliente extends StatelessWidget {
  const CalendarioCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      minDate: DateTime.now(),
    );
  }
}
