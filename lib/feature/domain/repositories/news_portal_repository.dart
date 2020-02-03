import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';

abstract class NewsPortalRepository {
  Future<Either<Failure, NewsPortal>> getNewsPortal(int skip, int top);
}