import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookingEvent {}

//class GetListRoomsEvent extends BookingEvent {
//  final String organization;
//  GetListRoomsEvent({@required this.organization});
//}

//class SearchUsersEvent extends BookingEvent {
//  final String value;
//  SearchUsersEvent({@required this.value});
//}

//class SelectResponsibleUser extends BookingEvent {
//  final BookingUsersModel model;
//  SelectResponsibleUser({@required this.model});
//}

//class GetCurrentBookingsEvent extends BookingEvent {
//  final String organization;
//  final String date;
//  final String roomTitle;
//  final int roomId;
//  final int officeId;
//  final bool hasProjector;
//  final bool hasVideoStaff;
//  final bool createNewReservation;
//  GetCurrentBookingsEvent({
//    this.organization,
//    this.date,
//    this.roomId,
//    this.officeId,
//    this.roomTitle,
//    this.hasProjector,
//    this.hasVideoStaff,
//    this.createNewReservation = false,
//  });
//}

//class RemoveByNameInternalParticipant extends BookingEvent {
//  final BookingUsersModel model;
//  RemoveByNameInternalParticipant({@required this.model});
//}
//
//class RemoveByNameExternalParticipant extends BookingEvent {
//  final BookingUsersModel model;
//  RemoveByNameExternalParticipant({@required this.model});
//}
//
//class AddInternalParticipant extends BookingEvent {
//  final BookingUsersModel model;
//  AddInternalParticipant({@required this.model});
//}
//
//class AddExternalParticipant extends BookingEvent {
//  final BookingUsersModel model;
//  AddExternalParticipant({@required this.model});
//}

//class CreateBookingEvent extends BookingEvent {}
//class RemoveBookingEvent extends BookingEvent {
//  final int id;
//  RemoveBookingEvent({@required this.id});
//}

