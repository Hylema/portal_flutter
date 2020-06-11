import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var res = DateTime.now();
    print(res.runtimeType);

    return Scaffold(
      appBar: HeaderAppBar(
        title: 'Календарь событий',
      ),
      body: CalendarScreen(),
//      body: CalendarDatePicker(
//        initialDate: DateTime.now(),
//        firstDate: DateTime(2019),
//        lastDate: DateTime(2021),
//        onDateChanged: (c) {},
//      ),
    );

//    return GestureDetector(
//      child: Center(child: Text('fff'),),
//      onTap: () async => await fut(context),
//    );
  }
}


class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;

  final Map<DateTime, List> _events = {
    DateTime(2020, 5, 7): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2020, 5, 9): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 10): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
      {'name': 'Event D', 'isDone': false},
      {'name': 'Event G', 'isDone': false},
      {'name': 'Event E', 'isDone': false},
    ],
    DateTime(2020, 5, 25): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Calendar(
            //dayBuilder: (BuildContext context, DateTime day) => Container(child: Text(day.toString()),),
            hideTodayIcon: true,
            hideBottomBar: true,
            weekDays: ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"],
            events: _events,
            onRangeSelected: (range) =>
                print("Range is ${range.from}, ${range.to}"),
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            eventDoneColor: Colors.redAccent,
            selectedColor: Colors.blueGrey[200],
            todayColor: Colors.yellow,
            eventColor: Colors.white,
            locale: 'ru',
            dayOfWeekStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 11),
          ),
        ),
        _buildEventList()
      ],
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {},
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}