import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/birthday/get_birthday_from_network.dart';
import './bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final GetBirthdayFromNetwork _getBirthdayFromNetwork;

  BirthdayBloc({
    @required GetBirthdayFromNetwork getBirthdayFromNetwork,
  }) :  assert(getBirthdayFromNetwork != null),
        _getBirthdayFromNetwork = getBirthdayFromNetwork;


  @override
  BirthdayState get initialState => EmptyBirthdayState();

  @override
  Stream<BirthdayState> mapEventToState(
    BirthdayEvent event,
  ) async* {
    if(event is GetBirthdayEvent){
      yield* _eitherLoadedOrErrorState(
          either: await _getBirthdayFromNetwork(
              BirthdayParams(
                  monthNumber: event.monthNumber,
                  dayNumber: event.dayNumber,
                  pageIndex: event.pageIndex,
                  pageSize: event.pageSize
              )
          )
      );
    }
  }

  Stream<BirthdayState> _eitherLoadedOrErrorState({
    Either either,
  }) async* {
    yield either.fold(
          (failure){
        return ErrorBirthdayState(message: mapFailureToMessage(failure));
      },
          (model){
        return LoadedBirthdayState(model: model);
      },
    );
  }
}
