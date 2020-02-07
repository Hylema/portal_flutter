import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if(event is WaitingEvent) yield Waiting();
    if(event is NeedAuthEvent) yield NeedAuth();
    if(event is LoadedEvent) yield Finish();
  }
}
