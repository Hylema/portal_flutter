import 'package:flutter/cupertino.dart';
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
    await localDataSource.updatePhoneBooksCache();
    return await remoteDataSource.getPhoneBookWithParams(params: params);
  }

  @override
  Future<List<PhoneBookModel>> fetchPhoneBook({
    @required PhoneBookParams params,
    bool update = false
  }) async {
    if(update) await localDataSource.updatePhoneBooksCache();

    List<PhoneBookModel> _result;

    final List<PhoneBookModel> _localDataSourceResponse = localDataSource.getPhoneBooksFromCache(params.parentCode);
    if(_localDataSourceResponse == null) {
      _result = await remoteDataSource.getPhoneBookWithParams(params: params);

      localDataSource.savePhoneBooksToCache(code: params.parentCode, listPhoneBooksOrUsers: _result);
    }
    else _result = _localDataSourceResponse;

    return _result;
  }

  @override
  Future<List<PhoneBookUserModel>> fetchPhoneBookUsers({
    @required PhoneBookUserParams params,
  }) async {
    List<PhoneBookUserModel> _result;

    final List<PhoneBookUserModel> _localDataSourceResponse = localDataSource.getPhoneBooksUserFromCache(params.departmentCode);
    if(_localDataSourceResponse == null) {
      _result = await remoteDataSource.getPhoneBookUsersWithParams(params: params);

      localDataSource.savePhoneBooksToCache(code: params.departmentCode, listPhoneBooksOrUsers: _result);
    }
    else _result = _localDataSourceResponse;

    return _result;
  }
}