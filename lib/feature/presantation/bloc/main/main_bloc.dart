import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/main/main_params_repository_interface.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
class MainBloc extends Bloc<MainEvent, MainState> {
  final IMainParamsRepository repository;

  MainBloc({@required this.repository});

//  @override
//  Stream<MainState> transformEvents(
//      Stream<MainEvent> events,
//      Stream<MainEvent> Function(MainEvent event) next) =>
//      super.transformEvents(
//        events.debounceTime(
//          Duration(milliseconds: 500),
//        ),
//        next,
//      );

  @override
  MainState get initialState => EmptyMainState();

//  MainState _initialState() {
//    try {
//      List<BirthdayModel> listModels = repository.getBirthdayFromCache();
//
//      return BirthdayFromCacheState(birthdays: listModels);
//    } catch(e){
//      return BirthdayFromCacheState(birthdays: []);
//    }
//  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {

    if(event is GetPositionPagesEvent){
      final MainParamsModel repositoryResult =
      repository.getPositionPages();

      yield LoadedMainParams(model: repositoryResult);

    } else if(event is SetPositionPagesEvent){
      await repository.setPositionPages(model: event.model);

      yield LoadedMainParams(model: event.model);
    } else if(event is UpdateMainParams){
      yield LoadedMainParams(model: event.model);
    }
  }
}
