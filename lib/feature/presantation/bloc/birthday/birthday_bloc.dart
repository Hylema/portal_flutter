import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/birthday/get_birthday_from_network.dart';
import './bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> with BlocHelper<BirthdayState> {
  final IBirthdayRepository repository;

  BirthdayBloc({@required this.repository});

  @override
  Stream<BirthdayState> transformEvents(
      Stream<BirthdayEvent> events,
      Stream<BirthdayState> Function(BirthdayEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  BirthdayState get initialState => EmptyBirthdayState();

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

  bool _showBirthdayDay = false;

  @override
  Stream<BirthdayState> mapEventToState(
      BirthdayEvent event,
  ) async* {
    final currentState = state;

    if(event is SetFilterBirthdayEvent){
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


      _showBirthdayDay = true;
      _title = event.title;

      yield* _fetchFirstBirthday(params: _params);
    }

    if(event is UpdateBirthdayEvent){
      _params.pageIndex = 1;
      yield* _fetchFirstBirthday(params: _params);
    }

    if(event is ResetFilterBirthdayEvent){
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

    if(event is FetchBirthdayEvent && !_hasReachedMax(currentState)){
      _params.pageIndex++;
      yield* _fetchBirthday(params: _params);
    }
  }

  Stream<BirthdayState> _fetchFirstBirthday({@required BirthdayParams params}) async* {
    Either<Failure, List<BirthdayModel>> repositoryResult =
    await repository.getBirthdayWithFilter(params: params);

    yield await repositoryResult.fold(
          (failure){
        if(failure is AuthFailure){
          return NeedAuthBirthday();
        }
        return ErrorBirthdayState(message: mapFailureToMessage(failure));
      },
          (listModel){
        return LoadedBirthdayState(birthdays: listModel, hasReachedMax: false, title: _title);
      },
    );
  }

  Stream<BirthdayState> _fetchBirthday({@required BirthdayParams params}) async* {
    final currentState = state;

    if(currentState is EmptyBirthdayState){
      yield* _fetchFirstBirthday(params: params);
    }

    if(currentState is LoadedBirthdayState){
      Either<Failure, List<BirthdayModel>> repositoryResult =
      await repository.getBirthdayWithFilter(params: params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (listModel){
          return listModel.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LoadedBirthdayState(
            birthdays: currentState.birthdays + listModel,
            hasReachedMax: false,
            title: _title
          );
        },
      );
    }
  }

  bool _hasReachedMax(BirthdayState state) =>
      state is LoadedBirthdayState && state.hasReachedMax;
}

class BirthdayParams {
  int pageIndex;
  int pageSize;
  int startDayNumber;
  int endDayNumber;
  int startMonthNumber;
  int endMonthNumber;
  String searchString;

  BirthdayParams({
    @required this.pageIndex,
    @required this.pageSize,
    @required this.startDayNumber,
    @required this.endDayNumber,
    @required this.startMonthNumber,
    @required this.endMonthNumber,
    @required this.searchString,
  });
}


//Map _params = createParams(map: {
//  'pageIndex': 0,
//  'pageSize': BIRTHDAY_PAGE_SIZE,
//  'startDayNumber': DateTime.now().day,
//  'endDayNumber': DateTime.now().day,
//  'startMonthNumber': DateTime.now().month,
//  'endMonthNumber': DateTime.now().month,
//});
//
//if(event is SetFilterBirthdayEvent){
//yield LoadingBirthdayState();
//
//print('search params ================= search params');
//
//_titleDate = event.titleDate;
//
//_params = createParams(map: {
//'pageIndex': _pageIndex,
//'pageSize': BIRTHDAY_PAGE_SIZE,
//'startDayNumber': event.startDayNumber,
//'endDayNumber': event.endDayNumber,
//'startMonthNumber': event.startMonthNumber,
//'endMonthNumber': event.endMonthNumber,
//'searchString': event.fio,
//});