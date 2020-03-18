import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';

import 'package:meta/meta.dart';

class NewsPortalRepository implements INewsPortalRepository{
  final NewsPortalRemoteDataSource remoteDataSource;
  final NewsPortalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsPortalRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  getRemoteData(skip, top) async {
    try {
      final remoteNewsPortal = await remoteDataSource.getNewsPortal(skip, top);
      localDataSource.cacheNewsPortal(remoteNewsPortal);
      return Right(remoteNewsPortal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  getLocalData() async {
    try {
      final localNewsPortal = await localDataSource.getLastNewsPortal();
      return Right(localNewsPortal);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NewsPortalModel>> getNewsFromNetwork(int skip, int top) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsPortal = await remoteDataSource.getNewsPortal(skip, top);
        localDataSource.cacheNewsPortal(remoteNewsPortal);
        return Right(remoteNewsPortal);
      } on AuthFailure {
        return Left(AuthFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, NewsPortalModel>> getNewsFromCache() async {
    try {
      final localNewsPortal = await localDataSource.getLastNewsPortal();
      return Right(localNewsPortal);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NewsPortalModel>> updateNewsOrNextNews(int skip, int top) async {
    if (await networkInfo.isConnected) {
      try {
        try {
          final remoteNewsPortal = await remoteDataSource.getNewsPortal(skip, top);
          localDataSource.cacheNewsPortal(remoteNewsPortal);
          return Right(remoteNewsPortal);
        } on ServerException {
          return Left(ServerFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}