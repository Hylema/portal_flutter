import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable{
  ProfileState([List props = const <dynamic>[]]) : super(props);
}

class InitialProfileState extends ProfileState {}
class LoadingProfileState extends ProfileState {}

class LoadedProfileFromCacheState extends ProfileState {
  final data;
  LoadedProfileFromCacheState({@required this.data});
}

class LoadedProfileState extends ProfileState {
  final ProfileModel model;

  LoadedProfileState({@required this.model}) : super([model]);
}

class ErrorProfileState extends ProfileState {
  final String message;

  ErrorProfileState({@required this.message}) : super([message]);
}
