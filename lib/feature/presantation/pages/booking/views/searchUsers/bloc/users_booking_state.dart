import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UsersBookingState {}

class InitialUsersBookingState extends UsersBookingState {}
class LoadedUsersBookingState extends UsersBookingState {
  final List<BookingUsersModel> models;

  LoadedUsersBookingState({@required this.models});
}
class LoadingUsersBookingState extends UsersBookingState {}
