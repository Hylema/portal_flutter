import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_network.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String AUTH_FAILURE_MESSAGE = 'Auth Failuer';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

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
  ProfileState get initialState => Empty();

  @override
  Stream<ProfileState> mapEventToState(
      ProfileEvent event,
      ) async* {
    if (event is GetProfileFromNetworkBlocEvent) {
      yield Loading();

      yield* _eitherLoadedOrErrorState(either: await _getProfileFromNetwork());
    } else if(event is GetProfileFromCacheBlocEvent){
      yield Loading();

      var modelOrFailure = await _failureOrModelCache(
        either: await _getProfileFromCache(),
      );

      yield modelOrFailure.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (model) => Loaded(model: model),
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
            print('данных нет в кэшэ');
        return await _getProfileFromNetwork();
      },
          (model){
            print('данные есть в кэшэ === $model');
            print('данные есть в кэшэ === ${model.profile}');
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
              return Auth();
            }
            return Error(message: _mapFailureToMessage(failure));
          },
          (model){
            print('все норм');
            return Loaded(model: model);
          },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case AuthFailure:
        return AUTH_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

