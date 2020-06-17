import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/calendar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/custom_calendar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
class CalendarPage extends StatelessWidget {

  final data = [
    {
      "title": "День Победы ",
      "date": "2020-05-09"
    },
    {
      "title": "Это вторник",
      "date": "2020-05-05"
    },
    {
      "title": "Это вторник",
      "date": "2020-05-12"
    },
    {
      "title": "Это вторник",
      "date": "2020-05-19"
    },
    {
      "title": "Это вторник",
      "date": "2020-05-26"
    }
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: HeaderAppBar(
        title: 'Календарь событий',
      ),
      body: Calendar(
//            bottomBarTextStyle: TextStyle(color: Colors.redAccent),
//            //dayBuilder: (BuildContext context, DateTime day) => Container(child: Text(day.toString()),),
//            weekDays: ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"],
        events: data,
//            onRangeSelected: (range) =>
//                print("Range is ${range.from}, ${range.to}"),
//            onDateSelected: (date) => _handleNewDate(date),
//            isExpandable: true,
//            eventDoneColor: Colors.redAccent,
//            selectedColor: Color.fromRGBO(235, 244, 255, 1),
//            todayColor: Colors.yellow,
//            eventColor: Colors.red,
//            locale: 'ru',
//            dayOfWeekStyle: TextStyle(
//                color: Colors.black,
//                fontWeight: FontWeight.w800,
//                fontSize: 11),
      )
    );
  }
}
