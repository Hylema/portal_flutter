import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';

import 'package:meta/meta.dart';

class BirthdayRepository implements IBirthdayRepository{
  final BirthdayRemoteDataSource remoteDataSource;
  final BirthdayLocalDataSource localDataSource;

  BirthdayRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<List<BirthdayModel>> fetchBirthday({
    @required BirthdayParams params,
  }) async {
    List<BirthdayModel> listModel =
    await remoteDataSource.getBirthdayWithParams(birthdayParams: params);

    await saveBirthdayToCache(listModels: listModel);

    return listModel;
  }

  @override
  Future<List<BirthdayModel>> updateBirthday({BirthdayParams params}) async {
    List<BirthdayModel> listModel =
    await remoteDataSource.getBirthdayWithParams(birthdayParams: params);

    await updateBirthdayCache(listModels: listModel);

    return listModel;
  }

  @override
  List<BirthdayModel> getBirthdayFromCache() =>
      localDataSource.getBirthdayFromCache();

  @override
  Future<void> saveBirthdayToCache({@required List<BirthdayModel> listModels}) async =>
      await localDataSource.saveBirthdayToCache(listModels: listModels);

  @override
  Future<void> updateBirthdayCache({@required List<BirthdayModel> listModels}) async =>
      await localDataSource.updateBirthdayCache(listModels: listModels);

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