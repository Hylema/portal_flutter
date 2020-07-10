import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:timetable/timetable.dart';
import 'package:timetable/src/content/timetable_content.dart';

class CustomShimmerTimeTable<E extends Event> extends Timetable<E> {
  const CustomShimmerTimeTable({
    Key key,
    @required controller,
    @required eventBuilder,
  }) : super(controller: controller, eventBuilder: eventBuilder);

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: <Widget>[
        Ink(
          color: Colors.grey[200],
          child: ListTile(
            title: Container(),
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