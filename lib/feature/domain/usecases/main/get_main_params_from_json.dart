import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/main/main_params_repository.dart';

class GetMainParamsFromJson extends UseCase<MainParams, NoParams> {
  final MainParamsRepository repository;

  GetMainParamsFromJson(this.repository);

  @override
  Future<Either<Failure, MainParams>> call(NoParams params) async {
    return await repository.getParamsFromJson();
  }
}