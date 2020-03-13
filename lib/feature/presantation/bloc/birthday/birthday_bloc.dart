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

BirthdayModel _oldData;
int _pageIndex = 1;
Map _params;
String _titleDate;

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> with BlocHelper<BirthdayState> {
  final IBirthdayRepository repository;

  BirthdayBloc({@required this.repository});

  @override
  BirthdayState get initialState => EmptyBirthdayState();

  @override
  Stream<BirthdayState> mapEventToState(
      BirthdayEvent event,
  ) async* {
    bool noData = false;

    if(event is SetFilterBirthdayEvent){
      yield LoadingBirthdayState();

      print('search params ================= search params');

      _titleDate = event.titleDate;

      _params = createParams(map: {
        'pageIndex': _pageIndex,
        'pageSize': BIRTHDAY_PAGE_SIZE,
        'startDayNumber': event.startDayNumber,
        'endDayNumber': event.endDayNumber,
        'startMonthNumber': event.startMonthNumber,
        'endMonthNumber': event.endMonthNumber,
        'searchString': event.fio,
      });

      print('search params ================= $_params');

      Either<Failure, BirthdayModel> repositoryResult =
      await repository.getBirthdayWithFilter(params: _params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
              _oldData = model;
          return LoadedBirthdayState(model: _oldData, titleDate: _titleDate);
        },
      );
    }

    if(event is UpdateBirthdayEvent){
      _params['pageIndex'] = _pageIndex.toString();

      Either<Failure, BirthdayModel> repositoryResult =
      await repository.getBirthdayWithFilter(params: _params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
          _oldData = model;
          return LoadedBirthdayState(model: _oldData, titleDate: _titleDate);
        },
      );
    }

    if(event is ResetFilterBirthdayEvent){
      yield LoadingBirthdayState();

      _params = createParams(map: {
        'pageIndex': _pageIndex,
        'pageSize': BIRTHDAY_PAGE_SIZE,
        'startDayNumber': DateTime.now().day,
        'endDayNumber': DateTime.now().day,
        'startMonthNumber': DateTime.now().month,
        'endMonthNumber': DateTime.now().month,
      });

      Either<Failure, BirthdayModel> repositoryResult =
      await repository.getBirthdayWithFilter(params: _params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
          _oldData = model;
          return LoadedBirthdayState(model: _oldData, titleDate: 'Сегодня');
        },
      );
    }

    if(event is LoadMoreBirthdayEvent){
      int pageIndex = int.parse(_params['pageIndex']) + 1;
      _params['pageIndex'] = pageIndex.toString();
      print('_params===================$_params');

      Either<Failure, BirthdayModel> repositoryResult =
      await repository.getBirthdayWithFilter(params: _params);

      yield await repositoryResult.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
              if(model.birthdays.length == 0) noData = true;
              _oldData = BirthdayModel(birthdays: [
                ..._oldData.birthdays,
                ...model.birthdays
              ]);
          return LoadedBirthdayState(model: _oldData, noData: noData, titleDate: _titleDate);
        },
      );
    }
  }
}
