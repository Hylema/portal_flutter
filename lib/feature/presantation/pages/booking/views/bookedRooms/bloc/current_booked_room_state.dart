import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrentBookedRoomState {}

class InitialCurrentBookedRoomState extends CurrentBookedRoomState {}
class LoadingCurrentBookedRoomState extends CurrentBookedRoomState {}
class LoadedCurrentBookedRoomState extends CurrentBookedRoomState {
  final List<CurrentBookingModel> currentBookingModel;

  LoadedCurrentBookedRoomState({
    @required this.currentBookingModel,
  });
}
