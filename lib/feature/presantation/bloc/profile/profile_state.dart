import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable{
  ProfileState([List props = const <dynamic>[]]) : super(props);
}

class InitialProfileState extends ProfileState {}
class EmptyProfile extends ProfileState {}
class LoadingProfile extends ProfileState {}
class NeedAuthProfile extends ProfileState {}

class LoadedProfile extends ProfileState {
  final ProfileModel model;

  LoadedProfile({@required this.model}) : super([model]){
    GlobalData.profile = model.profile;
  }
}

class ErrorProfile extends ProfileState {
  final String message;

  ErrorProfile({@required this.message}) : super([message]);
}
