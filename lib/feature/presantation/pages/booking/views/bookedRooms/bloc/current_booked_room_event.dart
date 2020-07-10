import 'package:meta/meta.dart';

@immutable
abstract class CurrentBookedRoomEvent {}

class GetCurrentBookingsEvent extends CurrentBookedRoomEvent {
  final String organization;
  final String date;
  final String roomTitle;
  final int roomId;
  final int officeId;
  final bool hasProjector;
  final bool hasVideoStaff;
  GetCurrentBookingsEvent({
    this.organization,
    this.date,
    this.roomId,
    this.officeId,
    this.roomTitle,
    this.hasProjector,
    this.hasVideoStaff,
  });
}

class RemoveBookingEvent extends CurrentBookedRoomEvent {
  final int id;
  RemoveBookingEvent({@required this.id});
}