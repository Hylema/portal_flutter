import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/datasources/phoneBook/phone_book_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/phoneBook/phone_book_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/phoneBook/phone_book_repository_interface.dart';

class PhoneBookRepository implements IPhoneBookRepository{
  final PhoneBookRemoteDataSource remoteDataSource;
  final PhoneBookLocalDataSource localDataSource;

  PhoneBookRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<List<PhoneBookModel>> firstFetchPhoneBook({
    @required PhoneBookParams params,
  }) async {
    List<PhoneBookModel> _result;

    await localDataSource.updatePhoneBooksCache();
    _result = await remoteDataSource.getPhoneBookWithParams(params: params);

    localDataSource.savePhoneBooksToCache(code: params.parentCode, listPhoneBooksOrUsers: _result);

    return _result;
  }

  @override
  Future<List<PhoneBookModel>> fetchPhoneBook({
    @required PhoneBookParams params,
    bool update = false
  }) async {
    if(update) await localDataSource.updatePhoneBooksCache();
    List<PhoneBookModel> _result;

    final String cacheKey = '${params.parentCode}_$PHONE_BOOK_CACHE_KEY';
    final List<PhoneBookModel> _localDataSourceResponse = getPhoneBookFromCache(key: cacheKey);

    if(_localDataSourceResponse == null) {
      _result = await remoteDataSource.getPhoneBookWithParams(params: params);

      localDataSource.savePhoneBooksToCache(code: '${params.parentCode}_$PHONE_BOOK_CACHE_KEY', listPhoneBooksOrUsers: _result);
    }
    else _result = _localDataSourceResponse;

    return _result;
  }

  @override
  Future<List<PhoneBookUserModel>> fetchPhoneBookUsers({
    @required PhoneBookUserParams params,
  }) async {
    List<PhoneBookUserModel> _result;

    final String cacheKey = '${params.departmentCode}_$PHONE_BOOK_USER_CACHE_KEY';
    final List<PhoneBookUserModel> _localDataSourceResponse = getPhoneBookUserFromCache(key: cacheKey);

    if(_localDataSourceResponse == null) {
      _result = await remoteDataSource.getPhoneBookUsersWithParams(params: params);

      localDataSource.savePhoneBooksToCache(code: '${params.departmentCode}_$PHONE_BOOK_USER_CACHE_KEY', listPhoneBooksOrUsers: _result);
      print('getPhoneBookFromCache<PhoneBookUserModel>(key: cacheKey) ================= ${getPhoneBookFromCache(key: cacheKey)}');
    }
    else _result = _localDataSourceResponse;

    return _result;
  }

  @override
  Future<List<PhoneBookUserModel>> searchPhoneBookUser({
    @required PhoneBookUserParams params,
  }) async => await remoteDataSource.getPhoneBookUsersWithParams(params: params);

  List<PhoneBookModel> getPhoneBookFromCache({
    @required String key,
  }) => localDataSource.getPhoneBooksFromCache(key);


  List<PhoneBookUserModel> getPhoneBookUserFromCache({
    @required String key,
  }) => localDataSource.getPhoneBooksUserFromCache(key);
}