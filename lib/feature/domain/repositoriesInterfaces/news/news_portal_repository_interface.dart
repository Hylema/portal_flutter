import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';

abstract class INewsPortalRepository {
  Future<Either<Failure, NewsPortalModel>> getNewsFromNetwork(int skip, int top);
  Future<Either<Failure, NewsPortalModel>> updateNewsOrNextNews(int skip, int top);
  Future<Either<Failure, NewsPortalModel>> getNewsFromCache();
}