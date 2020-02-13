import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/main/get_main_params_from_json.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/main/set_main_params_to_json.dart';
import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetMainParamsFromJson getMainParamsFromJson;
  final SetMainParamsToJson setMainParamsToJson;

  MainBloc({
    @required GetMainParamsFromJson getMainParamsFromJson,
    @required SetMainParamsToJson setMainParamsToJson,
  }) :  assert(getMainParamsFromJson != null),
        assert(setMainParamsToJson != null),
        getMainParamsFromJson = getMainParamsFromJson,
        setMainParamsToJson = setMainParamsToJson;

  @override
  MainState get initialState => EmptyMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if(event is GetParamsFromJsonForMainPageBlocEvent){
     var modelOrFailure = await getMainParamsFromJson(NoParams());

     yield modelOrFailure.fold(
           (failure){
         return ErrorMainParams(message: mapFailureToMessage(failure));
       },
           (model){
         return LoadedMainState(model: model);
       },
     );
    } else if(event is SetParamsToJsonForMainPageBlocEvent){
      var saveOrFail = await setMainParamsToJson(Main(params: event.params));
      //TODO нужна проверка
      var modelOrFailure = await getMainParamsFromJson(NoParams());

      yield modelOrFailure.fold(
            (failure){
          return ErrorMainParams(message: mapFailureToMessage(failure));
        },
            (model){
              print('model: $model');
          return LoadedMainState(model: model);
        },
      );

    }
  }
}
