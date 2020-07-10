import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/booking_bloc_data.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_search_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_user_search_model.dart';
import 'bloc.dart';

class BookingUserItemBloc extends Bloc<BookingUserItemEvent, BookingUserItemState> {
  final BookingRepository repository;
  final BookingBlocsData data;
  final BookingUserSearchModel viewModel;
  BookingUserItemBloc({
    @required this.repository,
    @required this.data,
    @required this.viewModel,
  }){
    _modelController = new StreamController<BookingUserSearchModel>();

    data.reservationRoomBloc.modelStream.listen((event) {
      checkThisUser();
    });
  }

  void init({@required BookingUsersModel user, @required bool internal}) {
    viewModel.internal = internal;
    viewModel.user = user;
  }

  StreamController<BookingUserSearchModel> _modelController;
  Stream<BookingUserSearchModel> get modelStream => _modelController.stream;

  List<BookingUsersModel> participantsNames = [];

  void checkThisUser() {
    if(viewModel.internal) participantsNames = data.reservationParams.internalParticipantsNames;
    else participantsNames = data.reservationParams.externalParticipantsNames;

    viewModel.isSelected = false;

    participantsNames.forEach((BookingUsersModel _model) {
      if(viewModel.user.key == _model.key){
        viewModel.isSelected = true;
        return;
      }
    });

    _modelController.add(viewModel);
  }

  void onSelected() {
    if(viewModel.isSelected){
      if(viewModel.internal) data.reservationRoomBloc.add(RemoveByNameInternalParticipant(model: viewModel.user));
      else data.reservationRoomBloc.add(RemoveByNameExternalParticipant(model: viewModel.user));
    } else {
      if(viewModel.internal) data.reservationRoomBloc.add(AddInternalParticipant(model: viewModel.user));
      else data.reservationRoomBloc.add(AddExternalParticipant(model: viewModel.user));
    }
  }

  @override
  BookingUserItemState get initialState => InitialBookingUserItemState();

  @override
  Stream<BookingUserItemState> mapEventToState(
    BookingUserItemEvent event,
  ) async* {}
}
