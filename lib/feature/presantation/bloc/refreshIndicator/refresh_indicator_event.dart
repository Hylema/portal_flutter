import 'package:meta/meta.dart';

@immutable
abstract class RefreshLineIndicatorEvent {}

class RefreshIndicatorValueChangeEvent extends RefreshLineIndicatorEvent {
  final value;

  RefreshIndicatorValueChangeEvent({@required this.value}){
    assert(value != null);
  }
}

class RefreshIndicatorLoadingEvent extends RefreshLineIndicatorEvent {}