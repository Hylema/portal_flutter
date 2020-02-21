import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/newsPopularity/news_popularity.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:dartz/dartz.dart';

class GetNewsPopularityUserFromJson implements UseCase<UserLikesSeen, NewsPopularityParams>{
  final INewsPopularityRepository repository;

  GetNewsPopularityUserFromJson(this.repository);

  @override
  Future<Either<Failure, UserLikesSeen>> call(NewsPopularityParams params) async {
    return await repository.getNewsPopularityUserFromJson(params.id);
  }
}

class NewsPopularityParams extends Equatable {
  final int id;

  NewsPopularityParams({
    @required this.id,
  }) : super([id]);
}