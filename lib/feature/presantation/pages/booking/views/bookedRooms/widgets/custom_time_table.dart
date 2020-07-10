import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:timetable/timetable.dart';
import 'package:timetable/src/content/timetable_content.dart';

class CustomTimetable<E extends Event> extends Timetable<E> {
  final CurrentBookedRoomBloc bloc;
  final String currentDate;
  const CustomTimetable({
    Key key,
    @required controller,
    @required eventBuilder,
    @required this.bloc,
    @required this.currentDate,
  }) : super(controller: controller, eventBuilder: eventBuilder);

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: <Widget>[
        Ink(
          color: Colors.grey[200],
          child: ListTile(
            onTap: () => DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//      maxTime: DateTime(DateTime.now().year, 12, 31),
              onChanged: (date) {},
              onConfirm: (result) {
                String formatData = DateFormat('yyyy-MM-dd').format(result);
                bloc.add(GetCurrentBookingsEvent(date: formatData));
              },
//      currentTime: DateTime.now(),
              locale: LocaleType.ru,
            ),
            title: Text(DateFormat('dd MMM yyyy').format(DateTime.parse(currentDate))),
            leading: Icon(Icons.create),
            dense: true,
          ),
        ),
        Expanded(
          child: TimetableContent<E>(
            controller: controller,
            eventBuilder: eventBuilder,
          ),
        ),
      ],
    );

    if (theme != null) {
      child = TimetableTheme(data: theme, child: child);
    }

    return child;
  }
}