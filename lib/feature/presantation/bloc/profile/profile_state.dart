import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable{
  ProfileState([List props = const <dynamic>[]]) : super(props);
}

class InitialProfileState extends ProfileState {}
class Empty extends ProfileState {}
class Loading extends ProfileState {}
class Auth extends ProfileState {}

class Loaded extends ProfileState {
  final ProfileModel model;

  Loaded({@required this.model}) : super([model]){
    print('model === $model');
    print('model.profile === ${model.profile}');
    GlobalData.profile = model.profile;
  }
}

class Error extends ProfileState {
  final String message;

  Error({@required this.message}) : super([message]);
}
