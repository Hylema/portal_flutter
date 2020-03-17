import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';

class ErrorCatcher {
  final NetworkInfo networkInfo;
  ErrorCatcher({@required this.networkInfo});

  Future<Either<Failure, List<Type>>> getDataFromNetwork<Type>({@required remoteMethod}) async {
    if(await networkInfo.isConnected){
      try {
        final List remoteData = await remoteMethod();
        print('remoteData ======== $remoteData');
        print('remoteData ======== ${remoteData.runtimeType}');
        return Right(remoteData);

      } on AuthException {
        return Left(AuthFailure());

      } on ServerException {
        return Left(ServerFailure());

      } on BadRequestException {
        return Left(BadRequestFailure());

      } on UnknownException {
        return Left(UnknownErrorFailure());

      } catch(errorMessage){
        print('Ошибка ======================= $errorMessage');
        return Left(ProgrammerFailure(errorMessage: errorMessage));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, Type>> getDataFromCache<Type>({@required localMethod}) async {
    try {
      final localData = await localMethod();
      return Right(localData);
    } catch(e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, Type>> setDataToCache<Type>({@required localMethod}) async {
    try {
      final localData = await localMethod();
      return Right(localData);
    } catch(e) {
      return Left(CacheFailure());
    }
  }
}