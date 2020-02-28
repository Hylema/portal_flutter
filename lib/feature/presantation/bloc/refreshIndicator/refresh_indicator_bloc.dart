import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RefreshLineIndicatorBloc extends Bloc<RefreshLineIndicatorEvent, RefreshLineIndicatorState> {
  @override
  RefreshLineIndicatorState get initialState => LoadedRefreshIndicatorState();

  @override
  Stream<RefreshLineIndicatorState> mapEventToState(
      RefreshLineIndicatorEvent event,
  ) async* {
    if(event is RefreshIndicatorValueChangeEvent){
      yield LoadedRefreshIndicatorState(value: event.value);
    } else if(event is RefreshIndicatorLoadingEvent){
      yield LoadingRefreshIndicatorState();
    }
  }
}
