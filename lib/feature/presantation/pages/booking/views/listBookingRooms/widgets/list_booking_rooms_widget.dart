import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/listBookingRooms/widgets/item_booking_room_widget.dart';

class ListBookingRoomsWidget extends StatelessWidget {

  final List<BookingRoomsModel> bookingRooms;
  final String organisation;
  ListBookingRoomsWidget({@required this.bookingRooms, @required this.organisation});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index){
            return ItemBookingRoomWidget(
              bookingRooms: bookingRooms[index],
              organisation: organisation,
              last: bookingRooms.length == index + 1
            );
          },
              childCount: bookingRooms.length
          ),
        ),
      ],
    );
  }
}