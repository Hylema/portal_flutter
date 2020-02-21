import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news/news_portal_repository_interface.dart';

class GetNewsPortalFromCache extends UseCase<NewsPortal, NoParams> {
  final INewsPortalRepository repository;

  GetNewsPortalFromCache(this.repository);

  @override
  Future<Either<Failure, NewsPortal>> call(NoParams params) async {
    return await repository.getNewsFromCache();
  }
}