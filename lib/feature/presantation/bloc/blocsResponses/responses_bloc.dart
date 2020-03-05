import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ResponsesBloc extends Bloc<ResponsesEvent, ResponsesState> {
  @override
  ResponsesState get initialState => EmptyState();

  @override
  Stream<ResponsesState> mapEventToState(
    ResponsesEvent event,
  ) async* {
    if(event is ResponseSuccessEvent) yield ResponseSuccessState(state: event.state);
    else if (event is ResponseErrorEvent) yield ResponseErrorState(state: event.state);
  }
}
