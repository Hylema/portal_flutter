import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/untils/calendar_untils.dart';
import 'package:intl/intl.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool isWeekend;
  final bool inMonth;
  final List events;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.isWeekend: false,
    this.inMonth: true,
    this.events,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromRGBO(235, 244, 255, 1),
              borderRadius: BorderRadius.circular(10),
            )
                : BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat("d").format(date),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: !isWeekend ? isSelected
                          ? Colors.red
                          : CalendarUtils.isSameDay(this.date, DateTime.now())
                          ? Colors.yellow
                          : inMonth ? Colors.black : Colors.grey[500] : Colors.grey[500]
                  ),
                ),
//                events != null && events.length > 0
//                    ? Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: events.map((event) {
//                      eventCount++;
//                      if (eventCount > 3) return Container();
//
//                      return Container(
//                        margin: EdgeInsets.only(
//                            left: 2.0, right: 2.0, top: 1.0),
//                        width: 5.0,
//                        height: 5.0,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          color: Colors.redAccent
//                        ),
//                      );
//
//                    }).toList())
//                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}