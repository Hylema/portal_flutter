import 'package:flutter_architecture_project/feature/data/datasources/auth/auth_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/auth/auth_repository_interface.dart';

import 'package:meta/meta.dart';

class AuthRepository implements IAuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  final BirthdayLocalDataSource localDataSource;

  AuthRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  void getToken({@required code}) async {
    await remoteDataSource.getFirstToken(code: code);
  }


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