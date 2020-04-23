import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';

abstract class IMainParamsRepository {
  List getPositionPages();
  Future<void> setPositionPages(params);
}