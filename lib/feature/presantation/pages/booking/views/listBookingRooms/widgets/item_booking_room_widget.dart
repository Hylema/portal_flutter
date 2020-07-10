import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/current_booked_room_view.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ItemBookingRoomWidget extends StatelessWidget {
  final BookingRoomsModel bookingRooms;
  final String organisation;
  final bool last;
  final getIt = GetIt.instance;
  ItemBookingRoomWidget({
    @required this.bookingRooms,
    @required this.organisation,
    @required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(bookingRooms.title),
              subtitle: Text(((bookingRooms.hasProjector == 'Да' ? 'Проектор' : '') + (bookingRooms.hasVideoStaff == 'Да' ? ', видеоконференции' : ''))),
              trailing: Icon(Icons.chevron_right),
              dense: true,
              onTap: () {
                final CurrentBookedRoomBloc currentBookedRoomBloc = getIt<CurrentBookedRoomBloc>();

                currentBookedRoomBloc.add(GetCurrentBookingsEvent(
                    organization: organisation,
                    roomId: bookingRooms.id,
                    officeId: bookingRooms.floor['id'],
                    roomTitle: bookingRooms.title,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    hasProjector: bookingRooms.hasProjector == 'Да' ? true : false,
                    hasVideoStaff: bookingRooms.hasVideoStaff == 'Да' ? true : false,
                ));

                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    CurrentBookedRoomView(
                        title: bookingRooms.title,
                        bloc: currentBookedRoomBloc,
                    )));
              }
          ),
          !last ? Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  width: 0.8,
                  color: Colors.grey[400],
                ))
            ),
          ) : Container()
        ],
      ),
    );
  }
}
