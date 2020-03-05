import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
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
  Future<Either<Failure, Birthday>> getBirthdayFromNetwork({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required int pageSize
  }) async{
    if (await networkInfo.isConnected) {
      try {
        final BirthdayModel remoteBirthday = await remoteDataSource.getBirthday(
          monthNumber: monthNumber,
          dayNumber: dayNumber,
          pageIndex: pageIndex,
          pageSize: pageSize
        );

        return Right(remoteBirthday);

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
}
