import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/repositories/repository.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:meta/meta.dart';

class BirthdayRepository extends Repository<BirthdayModel> implements IBirthdayRepository {
  final BirthdayRemoteDataSource remoteDataSource;
  final BirthdayLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BirthdayRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });

  int pageIndex = 0;

  @override
  Future<Either<Failure, BirthdayModel>> getBirthday({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageSize
  }) async {
    pageIndex++;
    if (await networkInfo.isConnected) {
      Either<Failure, BirthdayModel> _networkResult = await _getBirthdayFromNetwork(
        monthNumber: monthNumber,
        dayNumber: dayNumber,
        pageIndex: pageIndex,
        pageSize: pageSize,
      );

      Either<Failure, BirthdayModel> _cacheResult = await _getBirthdayFromCache();

      return await _networkResult.fold(
            (Failure failure){
          return Left(failure);
        },
            (BirthdayModel modelFromNetwork) async {
          if(pageIndex == 1){
            await _setBirthdayToCache(modelFromNetwork);
            return Right(BirthdayModel(birthdays: modelFromNetwork.birthdays));
          }
          return await _cacheResult.fold((Failure failure){}, (BirthdayModel modelFromCache) async {
            BirthdayModel _birthdayModel = BirthdayModel(birthdays: [...modelFromCache.birthdays, ...modelFromNetwork.birthdays]);
            await _setBirthdayToCache(_birthdayModel);
            return Right(BirthdayModel(birthdays: _birthdayModel.birthdays));
          });
        },
      );
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, BirthdayModel>> _getBirthdayFromNetwork({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required int pageSize
  }) async => await getDataFromNetwork(
      remoteMethod: (){
        return remoteDataSource.getBirthday(
          monthNumber: monthNumber,
          dayNumber: dayNumber,
          pageIndex: pageIndex,
          pageSize: pageSize,
        );
      }
  );

  Future<Either<Failure, BirthdayModel>> _getBirthdayFromCache() async =>
      await getDataFromCache(localMethod: () =>
          localDataSource.getBirthdayFromCache()
      );

  Future<void> _setBirthdayToCache(BirthdayModel model) async =>
      await setDataToCache(localMethod: () =>
          localDataSource.setBirthdayToCache(model: model)
      );
}
