import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/datasources/phoneBook/phone_book_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/phoneBook/phone_book_repository_interface.dart';

class PhoneBookRepository implements IPhoneBookRepository{
  final PhoneBookRemoteDataSource remoteDataSource;
  //final PhoneBookLocalDataSource localDataSource;

  PhoneBookRepository({
    @required this.remoteDataSource,
    //@required this.localDataSource,
  });

  @override
  Future<List<PhoneBookModel>> fetchPhoneBook({
    @required PhoneBookParams params,
    bool update = false
  }) async {
    final List<PhoneBookModel> _response = await remoteDataSource.getPhoneBookWithParams(params: params);

//    if(update) await updateBirthdayCache(response: _response);
//    else await saveBirthdayToCache(response: _response);

    return _response;
  }
}