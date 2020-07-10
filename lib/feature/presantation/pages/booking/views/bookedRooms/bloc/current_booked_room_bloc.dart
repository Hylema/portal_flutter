import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/remove_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/booking_bloc_data.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/models/reservation_viewmodel.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class CurrentBookedRoomBloc extends Bloc<CurrentBookedRoomEvent, CurrentBookedRoomState> {
  final BookingRepository repository;
  final BookingBlocsData data;
  CurrentBookedRoomBloc({
    @required this.repository,
    @required this.data,
  });

  @override
  CurrentBookedRoomState get initialState => InitialCurrentBookedRoomState();

  @override
  Stream<CurrentBookedRoomState> mapEventToState(
    CurrentBookedRoomEvent event,
  ) async* {
    if(event is GetCurrentBookingsEvent) yield* _getCurrentBookings(event);
    if(event is RemoveBookingEvent) yield* _removeBooking(event);
  }

  BehaviorSubject<ReservationModel> _modelController;
  ValueStream<ReservationModel> get modelStream => _modelController.stream;

  Stream<CurrentBookedRoomState> _getCurrentBookings(GetCurrentBookingsEvent event) async* {
    yield LoadingCurrentBookedRoomState();

    if(state != LoadedCurrentBookedRoomState){
      data.currentBookingParams = new CurrentBookingParams();
      data.currentBookingParams.organization = event.organization ?? data.currentBookingParams.organization;
      data.currentBookingParams.date = event.date ?? data.currentBookingParams.date;
      data.currentBookingParams.roomId = event.roomId ?? data.currentBookingParams.roomId;

      data.reservationParams = new ReservationParams();
      data.reservationParams.roomTitle = event.roomTitle;
      data.reservationParams.projector = event.hasProjector;
      data.reservationParams.videoStaff = event.hasVideoStaff;
      data.reservationParams.roomId = event.roomId;
      data.reservationParams.officeId = event.officeId;
    }

    if(data.reservationParams.meetingType == null){
      data.reservationParams.meetingType = await repository.getMeetingTypes(organisation: data.currentBookingParams.organization);
    }

    List<CurrentBookingModel> repositoryResult = await repository.fetchCurrentBookings(
      currentBookingParams: data.currentBookingParams,
    );

    yield LoadedCurrentBookedRoomState(
        currentBookingModel: repositoryResult,
    );
  }


  Stream<CurrentBookedRoomState> _removeBooking(RemoveBookingEvent event) async* {
    final currentState = state;
    yield LoadingCurrentBookedRoomState();

    removeBookingParams = new RemoveBookingParams(
        organization: data.currentBookingParams.organization,
        id: event.id
    );

    if(await repository.removeBooking(
      removeBookingParams: removeBookingParams,
    )){
      List<CurrentBookingModel> repositoryResult = await repository.fetchCurrentBookings(
        currentBookingParams: data.currentBookingParams,
      );

      yield LoadedCurrentBookedRoomState(
          currentBookingModel: repositoryResult,
      );
    } else yield currentState;
  }

  RemoveBookingParams removeBookingParams;
}
