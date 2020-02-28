import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SelectedIndexBloc extends Bloc<SelectedIndexEvent, SelectedIndexState> {
  @override
  SelectedIndexState get initialState => LoadedSelectedIndexState();

  @override
  Stream<SelectedIndexState> mapEventToState(
    SelectedIndexEvent event,
  ) async* {
    if(event is UpdateIndexEvent){
      yield LoadedSelectedIndexState(index: event.index);
    }
  }
}
