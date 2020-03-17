import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:http/http.dart' as http;

abstract class IBirthdayRemoteDataSource {

  Future<List<BirthdayModel>> getBirthdayWithConcreteDay({
    @required BirthdayParams params
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
    @required BirthdayParams params
}) async {
    String uri = Uri.http('mi-portal-mobile.westeurope.cloudapp.azure.com:8080', '/api/birthdays', {}).toString();

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
    print('дошел = 2');
    String uri = Uri.http('mi-portal-mobile.westeurope.cloudapp.azure.com:8080', '/api/birthdays/filter', createParams(map: {
      'pageIndex': birthdayParams.pageIndex.toString(),
      'pageSize': birthdayParams.pageSize.toString(),
      'startDayNumber': birthdayParams.startDayNumber.toString(),
      'endDayNumber': birthdayParams.endDayNumber.toString(),
      'startMonthNumber': birthdayParams.startMonthNumber.toString(),
      'endMonthNumber': birthdayParams.endMonthNumber.toString(),
      'searchString': birthdayParams.searchString,
    })).toString();

    print('uri ========================= $uri');

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    print('response ========================= ${response.body}');
    List<BirthdayModel> res = responseHandler(response: response, model: BirthdayModel.fromJson);
    print('res ========================= ${res}');
    print('res ========================= ${res.runtimeType}');

    return res;
  }
}
