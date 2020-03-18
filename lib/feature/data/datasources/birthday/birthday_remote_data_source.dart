import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday_params.dart';
import 'package:http/http.dart' as http;

abstract class IBirthdayRemoteDataSource {

  Future<List<BirthdayModel>> getBirthdayWithConcreteDay({
    @required BirthdayParams birthdayParams
  });

  Future<List<BirthdayModel>> getBirthdayWithFilter({
    @required BirthdayParams birthdayParams
  });
}

class BirthdayRemoteDataSource with ResponseHandler<BirthdayModel> implements IBirthdayRemoteDataSource {
  Storage storage;
  final http.Client client;

  BirthdayRemoteDataSource({
    @required this.storage,
    @required this.client,
  });

  @override
  Future<List<BirthdayModel>> getBirthdayWithConcreteDay({
    @required BirthdayParams birthdayParams
}) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/birthdays', birthdayParams.toMap()).toString();

    final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.secondToken}',
        },
    );

    return responseHandler(response: response, model: BirthdayModel.fromJson);
  }

  @override
  Future<List<BirthdayModel>> getBirthdayWithFilter({
    @required BirthdayParams birthdayParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/birthdays/filter', birthdayParams.toMap()).toString();

    final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.secondToken}',
        },
    );

    print('statusCode ---- ${response.statusCode}');

    return responseHandler(response: response, model: BirthdayModel.fromJson);
  }
}
