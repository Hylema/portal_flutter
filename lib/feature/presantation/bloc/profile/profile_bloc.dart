import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/profile/profile_repository_interface.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final IProfileRepository repository;
  final NetworkInfo networkInfo;

  ProfileBloc({@required this.repository, @required this.networkInfo});

  @override
  ProfileState get initialState => _profileFromCache();

  @override
  void onError(Object error, StackTrace stacktrace){
    add(GetProfileFromCacheEvent());
  }

  @override
  Stream<ProfileState> mapEventToState(
      ProfileEvent event,
      ) async* {
    if(event is GetProfileEvent) {
      ProfileModel repositoryResult = await repository.fetchProfile();

      yield LoadedProfileState(model: repositoryResult);
    } else if (event is GetProfileFromCacheEvent) {
      yield _profileFromCache();
    }
  }

  ProfileState _profileFromCache() {
    try {
      ProfileModel result = repository.getProfileFromCache();

      return LoadedProfileFromCacheState(data: result);
    } catch(e){
      return LoadedProfileFromCacheState(data: null);
    }
  }
}

