import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable{
  MainEvent([List props = const <dynamic>[]]) : super(props);
}

class GetParamsFromJsonForMainPageBlocEvent extends MainEvent {}
class SetParamsToJsonForMainPageBlocEvent extends MainEvent {
  final params;

  SetParamsToJsonForMainPageBlocEvent(this.params) : super([params]);
}