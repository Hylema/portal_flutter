import 'package:meta/meta.dart';

@immutable
abstract class BookingRoomsEvent {}

class GetListRoomsEvent extends BookingRoomsEvent {
  final String organization;
  GetListRoomsEvent({@required this.organization});
}