import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState{}

class EmptyMainState extends MainState {}
class LoadedMainState extends MainState {
  final MainParams model;

  LoadedMainState({@required this.model});
}
class ErrorMainParams extends MainState {
  final String message;

  ErrorMainParams({@required this.message});
}
