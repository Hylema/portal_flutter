import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;

abstract class IPhoneBookRemoteDataSource {
  Future<List<PhoneBookModel>> getPhoneBookWithParams({
    @required PhoneBookParams params,
  });
  Future<List<PhoneBookUserModel>> getPhoneBookUsersWithParams({
    @required PhoneBookUserParams params,
  });
}

class PhoneBookRemoteDataSource with ResponseHandler implements IPhoneBookRemoteDataSource {
  final Storage storage;
  final http.Client client;

  PhoneBookRemoteDataSource({@required this.client, @required this.storage});

  @override
  Future<List<PhoneBookModel>> getPhoneBookWithParams({
    @required PhoneBookParams params,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/departments', params.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    return listModels<PhoneBookModel>(response: response, model: PhoneBookModel.fromJson, key: 'data');
  }

  @override
  Future<List<PhoneBookUserModel>> getPhoneBookUsersWithParams({
    @required PhoneBookUserParams params,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/v2/users', params.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    return listModels<PhoneBookUserModel>(response: response, model: PhoneBookUserModel.fromJson, key: 'data');
  }
}

