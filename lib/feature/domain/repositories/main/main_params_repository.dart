import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';

abstract class IMainParamsRepository {
  Future<Either<Failure, MainParams>> getParamsFromJson();
  Future<Either<Failure, MainParams>> setParamsToJson(params);
}