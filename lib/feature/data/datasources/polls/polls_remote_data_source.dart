import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:http/http.dart' as http;

abstract class IPollsRemoteDataSource {

  Future<List<PollsModel>> getCurrentPolls();

  Future<List<PollsModel>> getPastPolls();
}

class PollsRemoteDataSource with ResponseHandler implements IPollsRemoteDataSource {
  Storage storage;
  final http.Client client;

  PollsRemoteDataSource({
    @required this.storage,
    @required this.client,
  });

  @override
  Future<List<PollsModel>> getCurrentPolls() async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/polls/current').toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<PollsModel>(response: response, model: PollsModel.fromJson, key: 'data');
  }

  @override
  Future<List<PollsModel>> getPastPolls() async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/polls/past').toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<PollsModel>(response: response, model: PollsModel.fromJson, key: 'data');
  }
}
