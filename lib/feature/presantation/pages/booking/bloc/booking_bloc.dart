import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/remove_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/search_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {

  final BookingRepository repository;
  BookingBloc({@required this.repository}){
    _subjectCounter = new BehaviorSubject<int>.seeded(this.initialCount); //initializes the subject with element already
  }

  int initialCount = 0; //if the data is not passed by paramether it initializes with 0
  BehaviorSubject<int> _subjectCounter;


  ValueStream<int> get counterObservable => _subjectCounter.stream;

  void increment(){
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement(){
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose(){
    _subjectCounter.close();
  }

  @override
  BookingState get initialState => InitialBookingState();

  String someInput = 'Какая-то строка';

  @override
  Stream<BookingState> mapEventToState(
    BookingEvent event,
  ) async* {
//    if(event is GetListRoomsEvent) yield* _getListRooms(event);
//    if(event is GetCurrentBookingsEvent) yield* _getCurrentBookings(event);
//    if(event is SearchUsersEvent) yield* _getSearchUsers(event);
//    if(event is SelectResponsibleUser) yield* _getSelectResponsibleUser(event);
//    if(event is RemoveByNameInternalParticipant) yield* _removeByNameInternalParticipant(event);
//    if(event is RemoveByNameExternalParticipant) yield* _removeByNameExternalParticipant(event);
//    if(event is AddInternalParticipant) yield* _addInternalParticipant(event);
//    if(event is AddExternalParticipant) yield* _addExternalParticipant(event);
//    if(event is CreateBookingEvent) yield* _createBooking(event);
//    if(event is RemoveBookingEvent) yield* _removeBooking(event);
  }

//  Stream<BookingState> _getCurrentBookings(GetCurrentBookingsEvent event) async* {
//    yield LoadingBookingState(lastRooms: repository.getLastCurrentBookingRooms());
//    _currentBookingParams.organization = event.organization ?? _currentBookingParams.organization;
//    _currentBookingParams.date = event.date ?? _currentBookingParams.date;
//    _currentBookingParams.roomId = event.roomId ?? _currentBookingParams.roomId;
//
//    if(event.createNewReservation){
//      _reservationParams = new ReservationParams();
//      _reservationParams.roomTitle = event.roomTitle;
//      _reservationParams.projector = event.hasProjector;
//      _reservationParams.videoStaff = event.hasVideoStaff;
//      _reservationParams.roomId = event.roomId;
//      _reservationParams.officeId = event.officeId;
//    }
//
//    List<CurrentBookingModel> repositoryResult = await repository.fetchCurrentBookings(
//      currentBookingParams: _currentBookingParams,
//      reservationParams: _reservationParams,
//    );
//
//    yield LoadedCurrentBookingsState(
//        currentBookingModel: repositoryResult,
//        reservationParams: _reservationParams,
//        currentBookingParams: _currentBookingParams
//    );
//  }

//  Stream<BookingState> _getListRooms(GetListRoomsEvent event) async* {
//    yield LoadingBookingState();
//    _bookingRoomsParams.organization = event.organization;
//    List<BookingRoomsModel> repositoryResult = await repository.fetchBookingRooms(params: _bookingRoomsParams);
//    yield LoadedListBookingRoomsState(bookingRooms: repositoryResult, params: _bookingRoomsParams);
//  }

//  Stream<BookingState> _getSearchUsers(SearchUsersEvent event) async* {
//    yield LoadingBookingState();
//
//    _searchParams = new SearchParams(
//      value: event.value
//    );
//
//    List<BookingUsersModel> repositoryResult = await repository.searchUsers(params: _searchParams);
//
//    yield LoadedBookingUsersState(models: repositoryResult);
//  }

//  Stream<BookingState> _getSelectResponsibleUser(SelectResponsibleUser event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);
//    _reservationParams.responsibleId = repositoryResult.id;
//    _reservationParams.responsibleName = event.model.name;
//
//    yield currentState;
//  }

//  Stream<BookingState> _addInternalParticipant(AddInternalParticipant event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    if(!_reservationParams.internalParticipantsNames.contains(event.model)) {
//      _reservationParams.internalParticipantsNames.add(event.model);
//      BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);
//
//      _reservationParams.internalParticipants.add(repositoryResult.id);
//    }
//
//    yield currentState;
//  }
//
//  Stream<BookingState> _addExternalParticipant(AddExternalParticipant event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    if(!_reservationParams.externalParticipantsNames.contains(event.model)) {
//      _reservationParams.externalParticipantsNames.add(event.model);
//      BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);
//
//      _reservationParams.externalParticipants.add(repositoryResult.id);
//    }
//
//    yield currentState;
//  }
//
//  Stream<BookingState> _removeByNameInternalParticipant(RemoveByNameInternalParticipant event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    _reservationParams.internalParticipantsNames.asMap().forEach((int _index, BookingUsersModel _model) {
//      if(_model.key == event.model.key) _reservationParams.internalParticipants.removeAt(_index);
//    });
//    _reservationParams.internalParticipantsNames.removeWhere((BookingUsersModel _model) => _model.key == event.model.key);
//
//    yield currentState;
//  }
//
//  Stream<BookingState> _removeByNameExternalParticipant(RemoveByNameExternalParticipant event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    _reservationParams.externalParticipantsNames.asMap().forEach((int _index, BookingUsersModel _model) {
//      if(_model.key == event.model.key) _reservationParams.externalParticipants.removeAt(_index);
//    });
//    _reservationParams.externalParticipantsNames.removeWhere((BookingUsersModel _model) => _model.key == event.model.key);
//
//    yield currentState;
//  }

//  Stream<BookingState> _createBooking(CreateBookingEvent event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    _reservationParams.organization = _bookingRoomsParams.organization;
//
//    if(await repository.createBooking(
//        reservationParams: _reservationParams,
//    )){
//      final List<CurrentBookingModel> repositoryResult = await repository.fetchCurrentBookings(
//        currentBookingParams: _currentBookingParams,
//      );
//
//      yield LoadedCurrentBookingsState(
//          currentBookingModel: repositoryResult,
//      );
//    } else yield currentState;
//  }

//  Stream<BookingState> _removeBooking(RemoveBookingEvent event) async* {
//    final currentState = state;
//    yield LoadingBookingState();
//
//    _removeBookingParams = new RemoveBookingParams(
//        organization: _bookingRoomsParams.organization,
//        id: event.id
//    );
//
//    if(await repository.removeBooking(
//      removeBookingParams: _removeBookingParams,
//    )){
//      List<CurrentBookingModel> repositoryResult = await repository.fetchCurrentBookings(
//        currentBookingParams: _currentBookingParams,
//        reservationParams: _reservationParams,
//      );
//
//      yield LoadedCurrentBookingsState(
//          currentBookingModel: repositoryResult,
//          reservationParams: _reservationParams,
//          currentBookingParams: _currentBookingParams
//      );
//    } else yield currentState;
//  }

  BookingRoomsParams _bookingRoomsParams = new BookingRoomsParams(organization: METALLOINVEST);
  CurrentBookingParams _currentBookingParams = new CurrentBookingParams();
  ReservationParams _reservationParams;
  RemoveBookingParams _removeBookingParams;
  SearchParams _searchParams;
}
