import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/booking_bloc_data.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class BookingRoomsBloc extends Bloc<BookingRoomsEvent, BookingRoomsState> {
  final BookingRepository repository;
  final BookingBlocsData data;
  BookingRoomsBloc({
    @required this.repository,
    @required this.data,
  }){
    _organisation = new BehaviorSubject<String>.seeded(METALLOINVEST);
  }

  BehaviorSubject<String> _organisation;

  ValueStream<String> get organisationName => _organisation.stream;

  void _setNewOrganisation(String organisation){
    _bookingRoomsParams.organization = organisation;
    _organisation.sink.add(organisation);
  }

  void dispose(){
    _organisation.close();
  }

  @override
  BookingRoomsState get initialState => InitialBookingRoomsState();

  @override
  Stream<BookingRoomsState> mapEventToState(
    BookingRoomsEvent event,
  ) async* {
    if(event is GetListRoomsEvent) yield* _getListRooms(event);
  }


  Stream<BookingRoomsState> _getListRooms(GetListRoomsEvent event) async* {
    yield LoadingBookingRoomsState();
    _setNewOrganisation(event.organization);
    List<BookingRoomsModel> repositoryResult = await repository.fetchBookingRooms(params: _bookingRoomsParams);
    yield LoadedBookingRoomsState(bookingRooms: repositoryResult, params: _bookingRoomsParams);
  }

  BookingRoomsParams _bookingRoomsParams = new BookingRoomsParams(organization: METALLOINVEST);
}
