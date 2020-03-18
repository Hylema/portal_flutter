import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/newsPopularity/news_popularity_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/newsPopularity/news_popularity_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/newsPopularity/news_popularity_repository_interface.dart';

import 'package:meta/meta.dart';

class NewsPopularityRepository implements INewsPopularityRepository {
  final NewsPopularityRemoteDataSource remoteDataSource;
//  final NewsPortalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsPopularityRepository({
    @required this.remoteDataSource,
//    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NewsPopularityModel>> getNewsPopularity(int id) async {
    try {
      return Right(await remoteDataSource.getNewsPopularity(id));
    } catch(e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NewsPopularityModel>> getNewsPopularityUserFromJson(int id) {
    // TODO: implement getNewsPopularityUserFromJson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> setUserLikedPageToJson(int id, List page) {
    // TODO: implement setUserLikedPageToJson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> setUserSeePage(int newsId) {
    // TODO: implement setUserSeenPageToJson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DocumentSnapshot>>> loadingPopularity() async{
    try {
      return Right(await remoteDataSource.loadingPopularity());
    } catch(e) {
      return Left(ServerFailure());
    }
  }



}