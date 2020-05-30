import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';

abstract class IMainParamsRepository {
  MainParamsModel getPositionPages();
  Future<void> setPositionPages({@required MainParamsModel model});
}