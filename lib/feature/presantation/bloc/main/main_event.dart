import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class GetPositionWidgetsEvent extends MainEvent {}

class SavePositionWidgetsEvent extends MainEvent {
  final MainParamsModel model;

  SavePositionWidgetsEvent({@required this.model});
}