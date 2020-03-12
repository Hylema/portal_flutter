import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/repositories/error_catcher.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:meta/meta.dart';

class BirthdayRepository implements IBirthdayRepository{
  final BirthdayRemoteDataSource remoteDataSource;
  final BirthdayLocalDataSource localDataSource;
  final ErrorCatcher errorCatcher;

  BirthdayRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.errorCatcher
  });

  @override
  Future<Either<Failure, BirthdayModel>> getBirthdayWithConcreteDay({
    @required params,
  }) async => await errorCatcher.getDataFromNetwork<BirthdayModel>(
      remoteMethod: () => remoteDataSource.getBirthdayWithConcreteDay(
          params: params
      ));

  @override
  Future<Either<Failure, BirthdayModel>> getBirthdayWithFilter({
    @required params,
  }) async => await errorCatcher.getDataFromNetwork<BirthdayModel>(
      remoteMethod: () => remoteDataSource.getBirthdayWithFilter(
        params: params
  ));

  @override
  Future<Either<Failure, BirthdayModel>> getBirthdayFromCache() async =>
      await errorCatcher.getDataFromCache<BirthdayModel>(localMethod: () =>
          localDataSource.getBirthdayFromCache()
      );

  @override
  Future<void> setBirthdayToCache({@required BirthdayModel model}) async =>
      await errorCatcher.setDataToCache<BirthdayModel>(localMethod: () =>
          localDataSource.setBirthdayToCache(model: model)
      );
}













//@override
//Future<Either<Failure, BirthdayModel>> getBirthdayWithConcreteDay({
//  @required int monthNumber,
//  @required int dayNumber,
//  @required int pageSize,
//  @required int pageIndex,
//  @required bool update,
//}) async {
//  bool noDataMore = false;
//
//  Either<Failure, BirthdayModel> _cacheResult = await _getBirthdayFromCache();
//
//  dynamic _birthdayModelFromCache = _cacheResult.fold(
//          (Failure failure) => failure,
//          (BirthdayModel modelFromCache) => modelFromCache);
//
//  if(_birthdayModelFromCache is !BirthdayModel)
//    return Left(_birthdayModelFromCache);
//
//  if (await networkInfo.isConnected) {
//
//    Either<Failure, BirthdayModel> _networkResult = await _getBirthdayFromNetwork(
//      monthNumber: monthNumber,
//      dayNumber: dayNumber,
//      pageIndex: pageIndex,
//      pageSize: pageSize,
//    );
//
//    dynamic _birthdayModelFromNetwork = _networkResult.fold(
//            (Failure failure) => failure,
//            (BirthdayModel modelFromNetwork) => modelFromNetwork);
//
//    if(_birthdayModelFromNetwork is !BirthdayModel)
//      return Left(_birthdayModelFromNetwork);
//
//    if(pageIndex == 1){
//      await _setBirthdayToCache(model: _birthdayModelFromNetwork);
//      return Right(_birthdayModelFromNetwork);
//    } else {
//      if(_birthdayModelFromNetwork.birthdays.length == 0) noDataMore = true;
//
//      BirthdayModel _birthdayModel = BirthdayModel(birthdays: [
//        ..._birthdayModelFromCache.birthdays,
//        ..._birthdayModelFromNetwork.birthdays
//      ]);
//
//      await _setBirthdayToCache(model: _birthdayModel);
//      return Right(BirthdayModel(birthdays: _birthdayModel.birthdays, noDataMore: noDataMore));
//    }
//  } else {
//    return Left(NetworkFailure());
//    //return Right(BirthdayModel(birthdays: _birthdayModelFromCache.birthdays, network: false));
//  }
//}