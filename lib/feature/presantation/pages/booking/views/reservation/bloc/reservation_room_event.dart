import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReservationRoomEvent {}

class CreateBookingEvent extends ReservationRoomEvent {}

class RemoveByNameInternalParticipant extends ReservationRoomEvent {
  final BookingUsersModel model;
  RemoveByNameInternalParticipant({@required this.model});
}

class RemoveByNameExternalParticipant extends ReservationRoomEvent {
  final BookingUsersModel model;
  RemoveByNameExternalParticipant({@required this.model});
}

class AddInternalParticipant extends ReservationRoomEvent {
  final BookingUsersModel model;
  AddInternalParticipant({@required this.model});
}

class AddExternalParticipant extends ReservationRoomEvent {
  final BookingUsersModel model;
  AddExternalParticipant({@required this.model});
}

class SelectResponsibleUser extends ReservationRoomEvent {
  final BookingUsersModel model;
  SelectResponsibleUser({@required this.model});
}
