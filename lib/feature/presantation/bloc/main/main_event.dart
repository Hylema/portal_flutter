import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class GetPositionPagesEvent extends MainEvent {}

class UpdateMainParams extends MainEvent {
  final params;

  UpdateMainParams(this.params);
}

class SetPositionPagesEvent extends MainEvent {
  final params;

  SetPositionPagesEvent(this.params);
}