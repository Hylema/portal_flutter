import 'package:meta/meta.dart';

@immutable
abstract class ReservationRoomState {}

class InitialReservationRoomState extends ReservationRoomState {}
class LoadingReservationRoomState extends ReservationRoomState {}
