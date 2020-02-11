import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_network.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileFormNetwork getProfileFormNetwork;
  final GetProfileFromCache getProfileFromCache;

  ProfileBloc({
    @required GetProfileFormNetwork getProfileFormNetwork,
    @required GetProfileFromCache getProfileFromCache,
  }) :  assert(getProfileFormNetwork != null),
        assert(getProfileFromCache != null),
        getProfileFormNetwork = getProfileFormNetwork,
        getProfileFromCache = getProfileFromCache;

  @override
  ProfileState get initialState => EmptyProfile();

  @override
  Stream<ProfileState> mapEventToState(
      ProfileEvent event,
      ) async* {
    if (event is GetProfileFromNetworkBlocEvent) {
      yield LoadingProfile();

      yield* _eitherLoadedOrErrorState(either: await _getProfileFromNetwork());
    } else if(event is GetProfileFromCacheBlocEvent){
      yield LoadingProfile();

      var modelOrFailure = await _failureOrModelCache(
        either: await _getProfileFromCache(),
      );

      yield modelOrFailure.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthProfile();
          }
          return ErrorProfile(message: mapFailureToMessage(failure));
        },
            (model){
          return LoadedProfile(model: model);
        },
      );
    }
  }

  _getProfileFromCache() async {
    return await getProfileFromCache(
        NoParams()
    );
  }

  _getProfileFromNetwork() async{
    return await getProfileFormNetwork(
        NoParams()
    );
  }

  _failureOrModelCache({
    Either<Failure, Profile> either,
  }) async {
    return either.fold(
          (failure) async {
        return await _getProfileFromNetwork();
      },
          (model){
        return Right(model);
      },
    );
  }

  Stream<ProfileState> _eitherLoadedOrErrorState({
    Either<Failure, Profile> either,
  }) async* {
    yield either.fold(
          (failure){
            if(failure is AuthFailure){
              return NeedAuthProfile();
            }
            return ErrorProfile(message: mapFailureToMessage(failure));
          },
          (model){
            return LoadedProfile(model: model);
          },
    );
  }
}

