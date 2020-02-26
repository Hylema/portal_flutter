import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/status_code.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:meta/meta.dart';

class BirthdayRepository implements IBirthdayRepository {
  final BirthdayRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BirthdayRepository({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Birthday>> getBirthdayFromNetwork(int monthNumber, int dayNumber, int pageIndex, int pageSize) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBirthday = await remoteDataSource.getBirthday(monthNumber, dayNumber, pageIndex, pageSize);
        return Right(remoteBirthday);
      } on AuthFailure {
        return Left(AuthFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch(e){
        ///TODO придумать альтернативу этому
        Status.message = e;
        return Left(UnknownErrorFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}