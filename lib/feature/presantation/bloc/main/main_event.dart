import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class GetParamsFromJsonForMainPageBlocEvent extends MainEvent {}

class UpdateMainParams extends MainEvent {
  final params;

  UpdateMainParams(this.params);
}

class SetParamsToJsonForMainPageBlocEvent extends MainEvent {
  final params;

  SetParamsToJsonForMainPageBlocEvent(this.params);
}