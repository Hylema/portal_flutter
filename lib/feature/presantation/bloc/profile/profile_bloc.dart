//import 'dart:async';
//import 'package:bloc/bloc.dart';
//import 'package:dartz/dartz.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/core/error/failure.dart';
//import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
//import './bloc.dart';
//
//class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with BlocHelper<ProfileState>{
//
//  @override
//  ProfileState get initialState => EmptyProfile();
//
//  @override
//  Stream<ProfileState> mapEventToState(
//      ProfileEvent event,
//      ) async* {
//    if (event is GetProfileFromNetworkEvent) {
//      print('сработало');
//      yield* _eitherLoadedOrErrorState(either: await _getProfileFromNetwork());
//    } else if(event is GetProfileFromCacheEvent){
//      yield LoadingProfile();
//
//      yield* _eitherLoadedOrErrorState(
//        either: await _eitherFailureOrModelCache(
//          either: await _getProfileFromCache(),
//        )
//      );
//    }
//  }
//
//  _getProfileFromCache() async {
//    return await getProfileFromCache(
//        NoParams()
//    );
//  }
//
//  _getProfileFromNetwork() async{
//    return await getProfileFormNetwork(
//        NoParams()
//    );
//  }
//
//  _eitherFailureOrModelCache({
//    Either<Failure, Profile> either,
//  }) async {
//    return either.fold(
//          (failure) async {
//        return await _getProfileFromNetwork();
//      },
//          (model){
//        return Right(model);
//      },
//    );
//  }
//
//  Stream<ProfileState> _eitherLoadedOrErrorState({
//    Either either,
//  }) async* {
//    yield either.fold(
//          (failure){
//            if(failure is AuthFailure){
//              return NeedAuthProfile();
//            }
//            return ErrorProfile(message: mapFailureToMessage(failure));
//          },
//          (model){
//            return LoadedProfile(model: model);
//          },
//    );
//  }
//}
//
