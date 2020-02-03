import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/data_news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/data_news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news_portal_repository.dart';
import 'package:meta/meta.dart';

typedef Future<NewsPortal> _ConcreteOrRandomChooser();

class NewsPortalRepositoryImpl implements NewsPortalRepository {
  final NewsPortalRemoteDataSource remoteDataSource;
  final NewsPortalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsPortalRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NewsPortal>> getNewsPortal(
      int skip,
      int top
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsPortal = await remoteDataSource.getNewsPortal(skip, top);
        localDataSource.cacheNewsPortal(remoteNewsPortal);
        return Right(remoteNewsPortal);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNewsPortal = await localDataSource.getLastNewsPortal();
        return Right(localNewsPortal);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}