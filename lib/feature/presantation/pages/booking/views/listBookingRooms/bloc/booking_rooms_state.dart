import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookingRoomsState {}

class InitialBookingRoomsState extends BookingRoomsState {}
class LoadedBookingRoomsState extends BookingRoomsState {
  final List<BookingRoomsModel> bookingRooms;
  final BookingRoomsParams params;

  LoadedBookingRoomsState({@required this.bookingRooms, @required this.params});
}
class LoadingBookingRoomsState extends BookingRoomsState {}
