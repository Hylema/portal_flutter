import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppEvent extends Equatable{
  AppEvent([List props = const <dynamic>[]]) : super(props);
}

class WaitingEvent extends AppEvent {}
class NeedAuthEvent extends AppEvent {}
class LoadedEvent extends AppEvent {}