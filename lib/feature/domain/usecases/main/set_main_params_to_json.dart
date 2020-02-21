import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/main/main_params_repository_interface.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class SetMainParamsToJson implements UseCase<MainParams, Main>{
  final IMainParamsRepository repository;

  SetMainParamsToJson(this.repository);

  @override
  Future<Either<Failure, MainParams>> call(Main params) async {
    return await repository.setParamsToJson(params.params);
  }
}

class Main extends Equatable {
  final params;

  Main({
    @required this.params,
  }) : super([params]);
}