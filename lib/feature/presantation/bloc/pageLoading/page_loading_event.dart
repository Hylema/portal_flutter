import 'package:meta/meta.dart';

@immutable
abstract class PageLoadingEvent {}

class SuccessLoading extends PageLoadingEvent {
  final state;
  SuccessLoading({@required this.state});
}
