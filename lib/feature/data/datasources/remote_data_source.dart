import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:http/http.dart' as http;

abstract class IRemoteDataSource {

  Future getDataFromNetwork({
    @required String url,
    @required token,
    @required Model model
  });
}

class RemoteDataSource<Type> implements IRemoteDataSource{
  final http.Client client;

  RemoteDataSource({
    @required this.client,
  });

  @override
  Future<Type> getDataFromNetwork({
    @required String url,
    @required token,
    @required Model model
  }) async {
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('response.statusCode================== ${response.statusCode}');

    switch(response.statusCode){
      case 200 : return model.fromJson(jsonDecode(utf8.decode(response.bodyBytes))) ;break;
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(); break;
      default: throw UnknownException(
        code: response.statusCode
      );
    }
  }

}