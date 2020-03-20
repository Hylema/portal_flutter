import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import './bloc.dart';

class PageLoadingBloc extends Bloc<PageLoadingEvent, PageLoadingState> {
  @override
  PageLoadingState get initialState => InitialPageLoadingState();

  @override
  Stream<PageLoadingState> mapEventToState(
    PageLoadingEvent event,
  ) async* {
    if(event is SuccessLoading) state[event.state] = true;


    bool allPageLoaded = true;
    state.forEach((key, value) {
      print('value ========================== $value');
      if(value == false) allPageLoaded = false;
    });

    if(allPageLoaded) yield AllPageLoaded();
  }
}

Map state = {
  LoadingBirthdayState: false,
};