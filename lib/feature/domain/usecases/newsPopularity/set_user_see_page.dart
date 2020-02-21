import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:dartz/dartz.dart';

class SetUserSeePage implements UseCase<bool, SetUserSeePageParams>{
  final INewsPopularityRepository repository;

  SetUserSeePage(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetUserSeePageParams params) async {
    return await repository.setUserSeePage(params.id);
  }
}

class SetUserSeePageParams extends Equatable {
  final int id;

  SetUserSeePageParams({
    @required this.id,
  }) : super([id]);
}