import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';

abstract class INewsPortalRepository {
  Future<Either<Failure, NewsPortal>> getNewsFromNetwork(int skip, int top);
  Future<Either<Failure, NewsPortal>> updateNewsOrNextNews(int skip, int top);
  Future<Either<Failure, NewsPortal>> getNewsFromCache();
}