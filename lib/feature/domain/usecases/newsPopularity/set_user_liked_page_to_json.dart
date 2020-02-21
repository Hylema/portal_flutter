import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:dartz/dartz.dart';

class SetUserLikedPageToJson implements UseCase<bool, NewsPopularityParams>{
  final INewsPopularityRepository repository;

  SetUserLikedPageToJson(this.repository);

  @override
  Future<Either<Failure, bool>> call(NewsPopularityParams params) async {
    return await repository.setUserLikedPageToJson(params.id, params.page);
  }
}

class NewsPopularityParams extends Equatable {
  final int id;
  final page;

  NewsPopularityParams({
    @required this.id,
    @required this.page,
  }) : super([id, page]);
}