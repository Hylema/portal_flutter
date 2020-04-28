import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/datasources/main/main_params_json_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/main/main_params_repository_interface.dart';

import 'package:meta/meta.dart';

class MainParamsRepository implements IMainParamsRepository {
  final MainParamsJsonDataSource localDataSource;

  MainParamsRepository({
    @required this.localDataSource,
  });

  @override
  MainParamsModel getPositionPages() {
    return localDataSource.getFromCache();
  }

  @override
  Future<void> setPositionPages({@required MainParamsModel model}) async {
    return await localDataSource.setToCache(model: model);
  }
}