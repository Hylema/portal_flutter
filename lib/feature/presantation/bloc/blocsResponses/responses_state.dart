import 'package:meta/meta.dart';

@immutable
abstract class ResponsesState {}

class ResponseSuccessState extends ResponsesState {
  final state;

  ResponseSuccessState({@required this.state}) : assert(state != null);
}

class ResponseErrorState extends ResponsesState {
  final state;

  ResponseErrorState({@required this.state}) : assert(state != null);
}

class EmptyState extends ResponsesState {}