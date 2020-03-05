import 'package:meta/meta.dart';

@immutable
abstract class ResponsesEvent {}

class ResponseSuccessEvent extends ResponsesEvent{
  final state;

  ResponseSuccessEvent({@required this.state}) : assert(state != null);
}

class ResponseErrorEvent extends ResponsesEvent{
  final state;

  ResponseErrorEvent({@required this.state}) : assert(state != null);
}
