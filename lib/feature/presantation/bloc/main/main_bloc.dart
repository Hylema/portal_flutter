//import 'dart:async';
//import 'package:bloc/bloc.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
//import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
//import './bloc.dart';
//
//class MainBloc extends Bloc<MainEvent, MainState> with BlocHelper<MainState>{
//
//  @override
//  MainState get initialState => EmptyMainState();
//
//  @override
//  Stream<MainState> mapEventToState(MainEvent event) async* {
//
//    if(event is GetParamsFromJsonForMainPageBlocEvent){
//     var modelOrFailure = await getMainParamsFromJson(NoParams());
//
//     yield modelOrFailure.fold(
//           (failure){
//         return ErrorMainParams(message: mapFailureToMessage(failure));
//       },
//           (model){
//         return LoadedMainParams(model: model);
//       },
//     );
//    } else if(event is SetParamsToJsonForMainPageBlocEvent){
//      var saveOrFail = await setMainParamsToJson(Main(params: event.params));
//      //TODO нужна проверка
//      var modelOrFailure = await getMainParamsFromJson(NoParams());
//
//      yield modelOrFailure.fold(
//            (failure){
//          return ErrorMainParams(message: mapFailureToMessage(failure));
//        },
//            (model){
//          return LoadedMainParams(model: model);
//        },
//      );
//    } else if(event is UpdateMainParams){
//
//      print('event ==== ${event.params}');
//
//      yield LoadedMainParams(model: MainParamsModel(params: event.params));
//    }
//  }
//}
