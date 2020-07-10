import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/search_params.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/listBookingRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/bloc/bloc.dart';

class BookingBlocsData {
  CurrentBookingParams currentBookingParams;
  ReservationParams reservationParams;
  SearchParams searchParams;

  BookingRoomsBloc bookingRoomsBloc;
  CurrentBookedRoomBloc currentBookedRoomBloc;
  ReservationRoomBloc reservationRoomBloc;
  UsersBookingBloc usersBookingBloc;
}



