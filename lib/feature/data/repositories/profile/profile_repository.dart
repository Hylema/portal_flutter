import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/profile/profile_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:meta/meta.dart';

class ProfileRepository implements IProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> getProfileFromNetwork() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsPortal = await remoteDataSource.getProfile();
        localDataSource.saveDataToCache(remoteNewsPortal);
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
  Future<Either<Failure, Profile>> getProfileFromCache() async {
    try {
      final localNewsPortal = await localDataSource.getDataFromCache();
      return Right(localNewsPortal);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}