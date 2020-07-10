import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/search_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/booking_bloc_data.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_search_model.dart';
import 'bloc.dart';

class UsersBookingBloc extends Bloc<UsersBookingEvent, UsersBookingState> {
  final BookingRepository repository;
  final BookingBlocsData data;
  final BookingSearchModel viewModel;
  UsersBookingBloc({
    @required this.repository,
    @required this.data,
    @required this.viewModel,
  }){
    _modelController = new StreamController<BookingSearchModel>();
  }

  void onChanged(String value) {

    if (viewModel.debounce?.isActive ?? false) viewModel.debounce.cancel();
    viewModel.debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchUsersEvent(value: value));
    });
  }

  void clearSearch() {
    viewModel.textEditingController.clear();
    add(SearchUsersEvent(value: ''));
  }

  StreamController<BookingSearchModel> _modelController;
  Stream<BookingSearchModel> get modelStream => _modelController.stream;

  @override
  UsersBookingState get initialState => InitialUsersBookingState();

  @override
  Stream<UsersBookingState> mapEventToState(
    UsersBookingEvent event,
  ) async* {
    if(event is SearchUsersEvent) yield* _getSearchUsers(event);
  }

  Stream<UsersBookingState> _getSearchUsers(SearchUsersEvent event) async* {
    yield LoadingUsersBookingState();

    data.searchParams = new SearchParams(
        value: event.value
    );

    List<BookingUsersModel> repositoryResult = await repository.searchUsers(params: data.searchParams);

    yield LoadedUsersBookingState(models: repositoryResult);
  }

}
