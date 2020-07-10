import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/shimmers/custom_shimmer_time_table.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';

class CurrentBookingPageShimmer extends StatelessWidget {
  final List<CurrentBookingModel> lastRooms;
  CurrentBookingPageShimmer({this.lastRooms});

  TimetableController<BasicEvent> _controller;

  @override
  Widget build(BuildContext context) {
    List<BasicEvent> listEvents = [];

    lastRooms.asMap().forEach((int index, CurrentBookingModel model) {
      final DateTime startDate = DateTime.parse(model.startDate);
      final DateTime endDate = DateTime.parse(model.endDate);

      listEvents.add(
          BasicEvent(
            id: index,
            title: model.title,
            color: Colors.grey,
            start: LocalDate.today().at(LocalTime(startDate.hour, startDate.minute, 0)),
            end: LocalDate.today().at(LocalTime(endDate.hour, endDate.minute, 0)),
          )
      );
    });

    _controller = TimetableController(
      eventProvider: EventProvider.list(listEvents),
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(1),
      firstDayOfWeek: DayOfWeek.monday,
    );

    return CustomShimmerTimeTable<BasicEvent>(
      controller: _controller,
      eventBuilder: (BasicEvent event) {
        return Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey[300],
          child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: event.color, width: 5)),
                color: event.color.withOpacity(0.3),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 2, 0, 0),
                    child: Text(event.title, style: TextStyle(color: Colors.black),),
                  ),
                  Expanded(
                    child: Text('${event.start.hourOfDay}:${event.start.minuteOfHour.toString().length == 1 ? event.start.minuteOfHour.toString() + '0' : event.start.minuteOfHour} - ${event.end.hourOfDay}:${event.end.minuteOfHour.toString().length == 1 ? event.end.minuteOfHour.toString() + '0' : event.end.minuteOfHour}', style: TextStyle(color: Colors.black),),
                  )
                ],
              )
          ),
          period: Duration(milliseconds: 800),
        );
      },
    );
  }
}
