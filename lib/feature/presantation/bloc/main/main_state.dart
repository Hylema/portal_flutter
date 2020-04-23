import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState{}

class EmptyMainState extends MainState {}
class LoadedMainParams extends MainState {
  final model;

  LoadedMainParams({@required this.model});
}
class ErrorMainParams extends MainState {
  final String message;

  ErrorMainParams({@required this.message});
}
