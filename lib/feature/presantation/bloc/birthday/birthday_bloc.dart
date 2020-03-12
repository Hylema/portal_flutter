import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/birthday/get_birthday_from_network.dart';
import './bloc.dart';

BirthdayModel _loadMoreBirthdayWithConcreteDayOldData;

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> with BlocHelper<BirthdayState> {
  final IBirthdayRepository repository;

  BirthdayBloc({@required this.repository});

  @override
  BirthdayState get initialState => EmptyBirthdayState();

  @override
  Stream<BirthdayState> mapEventToState(
      BirthdayEvent event,
  ) async* {
    if(event is LoadMoreBirthdayWithConcreteDayEvent){
      final params = removeParamsWithNull(map: {
        'monthNumber': event.monthNumber,
        'dayNumber': event.dayNumber,
        'pageIndex': event.pageIndex,
        'pageSize': event.pageSize
      });

      Either<Failure, BirthdayModel> repositoryResult =
      await repository.getBirthdayWithConcreteDay(params: params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
              if(event.pageIndex == 1) _loadMoreBirthdayWithConcreteDayOldData = model;
              else _loadMoreBirthdayWithConcreteDayOldData = BirthdayModel(birthdays: [
                ..._loadMoreBirthdayWithConcreteDayOldData.birthdays,
                ...model.birthdays
              ]);
          return LoadedBirthdayState(model: _loadMoreBirthdayWithConcreteDayOldData);
        },
      );
    }

    if(event is LoadMoreBirthdayWithFilterEvent){
      final params = removeParamsWithNull(map: {
        'startDayNumber': event.startDayNumber,
        'endDayNumber': event.endDayNumber,
        'startMonthNumber': event.startMonthNumber,
        'endMonthNumber': event.endMonthNumber,
        'fio': event.fio,
        'pageSize': event.pageSize,
        'pageIndex': event.pageIndex,
        'endMonthNumber': event.endMonthNumber,
      });

      yield await eitherLoadedOrErrorState(
        either: await repository.getBirthdayWithFilter(
          params: params
        ),
        ifNeedAuth: NeedAuthBirthday(),
        ifLoaded:  LoadedBirthdayState.getInstance,
        ifError: ErrorBirthdayState.getInstance,
      );
    }
  }
}
