import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState{}

class EmptyMainState extends MainState {}
class LoadedMainParams extends MainState {
  final MainParamsModel model;

  LoadedMainParams({@required this.model});
}
class ErrorMainParams extends MainState {
  final String message;

  ErrorMainParams({@required this.message});
}
