import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookingState {}

class InitialBookingState extends BookingState {}
class LoadedListBookingRoomsState extends BookingState {
  final List<BookingRoomsModel> bookingRooms;
  final BookingRoomsParams params;

  LoadedListBookingRoomsState({@required this.bookingRooms, @required this.params});
}
class LoadedCurrentBookingsState extends BookingState {
  final List<CurrentBookingModel> currentBookingModel;

  LoadedCurrentBookingsState({
    @required this.currentBookingModel,
  });
}
//class LoadedBookingUsersState extends BookingState {
//  final List<BookingUsersModel> models;
//
//  LoadedBookingUsersState({@required this.models});
//}
class LoadingBookingState extends BookingState {
  final List<CurrentBookingModel> lastRooms;
  LoadingBookingState({this.lastRooms});
}
