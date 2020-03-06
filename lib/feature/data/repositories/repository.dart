import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';

class Repository<Type> {
  Future<Either<Failure, Type>> getDataFromNetwork({@required remoteMethod}) async {
    try {
      final Type remoteData = await remoteMethod();

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
  }

  Future<Either<Failure, Type>> getDataFromCache({@required localMethod}) async {
    try {
      final localData = await localMethod();
      return Right(localData);
    } catch(e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, Type>> setDataToCache({@required localMethod}) async {
    try {
      final localData = await localMethod();
      return Right(localData);
    } catch(e) {
      return Left(CacheFailure());
    }
  }
}