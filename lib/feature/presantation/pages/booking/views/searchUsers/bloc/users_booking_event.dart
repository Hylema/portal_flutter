import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UsersBookingEvent {}

class SearchUsersEvent extends UsersBookingEvent {
  final String value;
  SearchUsersEvent({@required this.value});
}
