import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class GetPositionPagesEvent extends MainEvent {}

class UpdateMainParams extends MainEvent {
  final MainParamsModel model;

  UpdateMainParams({@required this.model});
}

class SetPositionPagesEvent extends MainEvent {
  final MainParamsModel model;

  SetPositionPagesEvent({@required this.model});
}