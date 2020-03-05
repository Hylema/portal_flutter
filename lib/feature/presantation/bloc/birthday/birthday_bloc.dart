import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/birthday/get_birthday_from_network.dart';
import './bloc.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> with BlocHelper {
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
    if(event is GetBirthdayEvent) yield* _getBirthdayNetwork(
        monthNumber: event.monthNumber,
        dayNumber: event.dayNumber,
        pageIndex: event.pageIndex,
        pageSize: event.pageSize
    );

    if(event is GetBirthdayFromCache) yield* _getBirthdayCache();
  }

  Stream<BirthdayState> _getBirthdayNetwork({
    @required monthNumber,
    @required dayNumber,
    @required pageIndex,
    @required pageSize,
  }) async* {
    yield await eitherLoadedOrErrorState(
        either: await _getBirthdayFromNetwork(
            BirthdayParams(
                monthNumber: monthNumber,
                dayNumber: dayNumber,
                pageIndex: pageIndex,
                pageSize: pageSize
            )
        ),
      ifNeedAuth: NeedAuthBirthday,
      ifLoaded: LoadedBirthdayState,
      ifError: ErrorBirthdayState,
    );
  }

  Stream<BirthdayState> _getBirthdayCache() async* {}
}
