import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/widgets/custom_time_table.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/widgets/details_booked.dart';
import 'package:timetable/timetable.dart';
import 'package:time_machine/time_machine.dart';

class BookingTimetable extends StatelessWidget {
  TimetableController<BasicEvent> _controller;

  final CurrentBookedRoomBloc bloc;
  final CurrentBookingParams params;
  final List<CurrentBookingModel> models;
  BookingTimetable({@required this.models, @required this.bloc, @required this.params});

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    List<BasicEvent> listEvents = [];

    models.asMap().forEach((int index, CurrentBookingModel model) {
      final DateTime startDate = DateTime.parse(model.startDate);
      final DateTime endDate = DateTime.parse(model.endDate);

      listEvents.add(
          BasicEvent(
            id: index,
            title: model.title,
            color: _colorFromHex(model.type['color']),
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

    return CustomTimetable<BasicEvent>(
      controller: _controller,
      bloc: bloc,
      currentDate: params.date,
      eventBuilder: (BasicEvent event) {
        return OpenContainer<bool>(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext context, VoidCallback _) => DetailsBooked(event: event, model: models[event.id], bloc: bloc),
          tappable: true,
          closedBuilder: (BuildContext context, VoidCallback _) => Container(
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
        );
      },
    );
  }
}