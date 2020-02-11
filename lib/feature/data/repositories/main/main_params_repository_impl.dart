import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/datasources/main/main_params_json_data_source.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/main/main_params_repository.dart';

import 'package:meta/meta.dart';

class MainParamsRepositoryImpl implements MainParamsRepository {
  final MainParamsJsonDataSourceImpl jsonDataSource;

  MainParamsRepositoryImpl({
    @required this.jsonDataSource,
  });

  @override
  Future<Either<Failure, MainParams>> getParamsFromJson() async{
    try {
      final data = await jsonDataSource.getFromJson();
      return Right(data);
    } on JsonException {
      return Left(JsonFailure());
    }
  }

  @override
  setParamsToJson(params) async{
    try {
      final data = await jsonDataSource.setToJson(params);
      return Right(data);
    } on JsonException {
      return Left(JsonFailure());
    }
  }
}