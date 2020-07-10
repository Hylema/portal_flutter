import 'package:meta/meta.dart';

@immutable
abstract class BookingUserItemState {}

class InitialBookingUserItemState extends BookingUserItemState {}
class LoadingBookingUserItemState extends BookingUserItemState {}
class LoadedBookingUserItemState extends BookingUserItemState {}
