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
    // TODO: Add Logic
  }
}
