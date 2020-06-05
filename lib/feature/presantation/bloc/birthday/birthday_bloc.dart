import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params_response.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_event.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import './bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final IBirthdayRepository repository;
  final NetworkInfo networkInfo;

  BirthdayBloc({@required this.repository, @required this.networkInfo});

  @override
  Stream<BirthdayState> transformEvents(
      Stream<BirthdayEvent> events,
      Stream<BirthdayState> Function(BirthdayEvent event) next) =>
      super.transformEvents(
        events.debounceTime(
          Duration(milliseconds: 500),
        ),
        next,
      );

  @override
  void onError(Object error, StackTrace stacktrace){
    add(GetBirthdayFromCache());
  }

  @override
  BirthdayState get initialState => _birthdayFromCache();

  @override
  Stream<BirthdayState> mapEventToState(
      BirthdayEvent event,
  ) async* {
    final currentState = state;

    if(await networkInfo.isConnected){
      if(event is SetNewBirthdayFilter) {
        yield LoadingBirthdayState();
        _params = event.params;
        yield* _firstFetchBirthday();
      }

      else if(event is UpdateBirthdayEvent) {
        _params.pageIndex = 1;
        yield* _firstFetchBirthday();
      }

      else if(event is FetchBirthdayEvent && !_hasReachedMax(currentState)) {
        _params.pageIndex++;
        yield* _fetchBirthday();
      }

      else if(event is GetBirthdayFromCache)
        yield _birthdayFromCache();

    } else {
      throw NetworkException();
    }
  }

  BirthdayState _birthdayFromCache() {
    try {
      BirthdayResponse result = repository.getBirthdayFromCache();

      return BirthdayFromCacheState(birthdays: result.listModels, title: result.title);
    } catch(e){
      return BirthdayFromCacheState(birthdays: [], title: 'Нет сохраненных данных в кэшэ');
    }
  }

  BirthdayParams _params = BirthdayParams(
      pageIndex: 1,
      pageSize: BIRTHDAY_PAGE_SIZE,
      dayNumber: DateTime.now().day,
      monthNumber: DateTime.now().month,
      startDayNumber: null,
      endDayNumber: null,
      startMonthNumber: null,
      endMonthNumber: null,
      searchString: null
  );

  Stream<BirthdayState> _firstFetchBirthday() async* {
    BirthdayResponse repositoryResult =
    await repository.fetchBirthday(params: _params, update: true);

    yield LoadedBirthdayState(birthdays: repositoryResult.listModels, hasReachedMax: false, title: repositoryResult.title);
  }

  Stream<BirthdayState> _fetchBirthday() async* {
    final currentState = state;

    if(currentState is LoadedBirthdayState){
      BirthdayResponse repositoryResult =
      await repository.fetchBirthday(params: _params);

      yield repositoryResult.listModels.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedBirthdayState(
          birthdays: currentState.birthdays + repositoryResult.listModels,
          hasReachedMax: false,
          title: repositoryResult.title,
      );
    }
  }

  bool _hasReachedMax(BirthdayState state) =>
      state is LoadedBirthdayState && state.hasReachedMax;
}

