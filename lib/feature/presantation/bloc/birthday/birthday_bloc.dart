import 'package:flutter_architecture_project/feature/domain/params/birthday_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import './bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> with BlocHelper<BirthdayState> {
  final IBirthdayRepository repository;

  BirthdayBloc({@required this.repository});

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
  BirthdayState get initialState => EmptyBirthdayState();

  @override
  Stream<BirthdayState> mapEventToState(
      BirthdayEvent event,
  ) async* {
    final currentState = state;

    if(event is SetFilterBirthdayEvent)
      yield* _setParamsFetchBirthday(event: event);

    if(event is UpdateBirthdayEvent)
      yield* _updateParamsFetchBirthday(event: event);

    if(event is ResetFilterBirthdayEvent)
      yield* _resetParamsFetchBirthday(event: event);

    if(event is FetchBirthdayEvent && !_hasReachedMax(currentState))
      yield* _fetchBirthdayWithParams(event: event);
  }

  BirthdayParams _params = BirthdayParams(
      pageIndex: 1,
      pageSize: BIRTHDAY_PAGE_SIZE,
      startDayNumber: DateTime.now().day,
      endDayNumber: DateTime.now().day,
      startMonthNumber: DateTime.now().month,
      endMonthNumber: DateTime.now().month,
      searchString: null
  );

  String _title = 'Сегодня';

  Stream<BirthdayState> _setParamsFetchBirthday({@required SetFilterBirthdayEvent event}) async* {
    yield LoadingBirthdayState();

    _params = BirthdayParams(
        pageIndex: 1,
        pageSize: BIRTHDAY_PAGE_SIZE,
        startDayNumber: event.startDayNumber,
        endDayNumber: event.endDayNumber,
        startMonthNumber: event.startMonthNumber,
        endMonthNumber: event.endMonthNumber,
        searchString: event.fio
    );

    _title = event.title;

    yield* _fetchFirstBirthday(params: _params);
  }

  Stream<BirthdayState> _updateParamsFetchBirthday({@required UpdateBirthdayEvent event}) async* {
    _params.pageIndex = 1;
    yield* _fetchFirstBirthday(params: _params);
  }

  Stream<BirthdayState> _resetParamsFetchBirthday({@required ResetFilterBirthdayEvent event}) async* {
    yield LoadingBirthdayState();

    _params = BirthdayParams(
        pageIndex: 1,
        pageSize: BIRTHDAY_PAGE_SIZE,
        startDayNumber: DateTime.now().day,
        endDayNumber: DateTime.now().day,
        startMonthNumber: DateTime.now().month,
        endMonthNumber: DateTime.now().month,
        searchString: null
    );

    _title = 'Сегодня';

    yield* _fetchFirstBirthday(params: _params);
  }

  Stream<BirthdayState> _fetchBirthdayWithParams({@required FetchBirthdayEvent event}) async* {
    _params.pageIndex++;
    yield* _fetchBirthday(params: _params);
  }

  Stream<BirthdayState> _fetchFirstBirthday({@required BirthdayParams params}) async* {
    List<BirthdayModel> repositoryResult =
    await repository.getBirthdayWithFilter(params: params);

    yield LoadedBirthdayState(birthdays: repositoryResult, hasReachedMax: false, title: _title);
  }

  Stream<BirthdayState> _fetchBirthday({@required BirthdayParams params}) async* {
    final currentState = state;

    if(currentState is EmptyBirthdayState){
      yield* _fetchFirstBirthday(params: params);
    }

    if(currentState is LoadedBirthdayState){
      List<BirthdayModel> repositoryResult =
      await repository.getBirthdayWithFilter(params: params);

      yield repositoryResult.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedBirthdayState(
          birthdays: currentState.birthdays + repositoryResult,
          hasReachedMax: false,
          title: _title
      );
    }
  }

  bool _hasReachedMax(BirthdayState state) =>
      state is LoadedBirthdayState && state.hasReachedMax;
}

