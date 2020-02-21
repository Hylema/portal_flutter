import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/newsPopularity/news_popularity.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:dartz/dartz.dart';

class GetNewsPopularityById implements UseCase<NewsPopularity, NewsPopularityParams>{
  final INewsPopularityRepository repository;

  GetNewsPopularityById(this.repository);

  @override
  Future<Either<Failure, NewsPopularity>> call(NewsPopularityParams params) async {
    return await repository.getNewsPopularity(params.id);
  }
}

class NewsPopularityParams extends Equatable {
  final int id;

  NewsPopularityParams({
    @required this.id,
  }) : super([id]);
}