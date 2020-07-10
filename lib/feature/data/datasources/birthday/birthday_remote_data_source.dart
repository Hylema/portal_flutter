import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;

abstract class IBirthdayRemoteDataSource {

  Future<List<BirthdayModel>> getStartEndDayBirthdayWithParams({
    @required BirthdayParams birthdayParams
  });

  Future<List<BirthdayModel>> getConcreteDayBirthdayWithParams({
    @required BirthdayParams birthdayParams
  });
}

class BirthdayRemoteDataSource with ResponseHandler implements IBirthdayRemoteDataSource {
  Storage storage;
  final http.Client client;

  BirthdayRemoteDataSource({
    @required this.storage,
    @required this.client,
  });

  @override
  Future<List<BirthdayModel>> getStartEndDayBirthdayWithParams({
    @required BirthdayParams birthdayParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/birthdays/filter', birthdayParams.toUrlParams()).toString();

    final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.secondToken}',
        },
    );

    return listModels<BirthdayModel>(response: response, model: BirthdayModel.fromJson, key: 'data');
  }

  @override
  Future<List<BirthdayModel>> getConcreteDayBirthdayWithParams({
    @required BirthdayParams birthdayParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/birthdays', birthdayParams.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    return listModels<BirthdayModel>(response: response, model: BirthdayModel.fromJson, key: 'data');
  }
}
