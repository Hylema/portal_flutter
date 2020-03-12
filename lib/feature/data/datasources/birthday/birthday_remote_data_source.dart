import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;

abstract class IBirthdayRemoteDataSource {

  Future<BirthdayModel> getBirthdayWithConcreteDay({
    @required Map params
  });

  Future<BirthdayModel> getBirthdayWithFilter({
    @required Map params
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
  Future<BirthdayModel> getBirthdayWithConcreteDay({
    @required Map params
}) async {
    String uri = Uri.http('mi-portal-mobile.westeurope.cloudapp.azure.com:8080', '/api/birthdays', params).toString();

    print('uri ========= $uri');

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    print('response ============= $response');

    return responseHandler(response: response, model: BirthdayModel.fromJson);
  }

  @override
  Future<BirthdayModel> getBirthdayWithFilter({
    @required params,
  }) async {
//    Uri uri = Uri.https('www.myurl.com', '/api/v1/test/${widget.pk}', queryParameters);
//    final url = '${Api.HOST_URL}:8080/api/birthdays?monthNumber=$monthNumber&dayNumber=$dayNumber&pageIndex=$pageIndex&pageSize=$pageSize';

    final response = await http.get(
      '',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    return responseHandler(response: response, model: BirthdayModel.fromJson);
  }
}
