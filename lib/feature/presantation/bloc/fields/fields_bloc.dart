import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  @override
  FieldsState get initialState => InitialFieldsState();

  @override
  Stream<FieldsState> mapEventToState(
    FieldsEvent event,
  ) async* {
    if(event is BirthdayParametersFilter){
      if(event.concreteDataMonth != null && event.concreteDataDay != null){
        print('concreteData =============== ${event.concreteDataDay}');
        yield ParametersWithConcreteDayState();
      } else {
        yield ParametersWithFilterState();
      }
    }
  }
}
