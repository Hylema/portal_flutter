import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/status_code.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;
abstract class IBirthdayRemoteDataSource {

  Future<BirthdayModel> getBirthday(int monthNumber, int dayNumber, int pageIndex, int pageSize);
}

class BirthdayRemoteDataSource implements IBirthdayRemoteDataSource {
  final http.Client client;
  Storage storage;

  BirthdayRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<BirthdayModel> getBirthday(int monthNumber, int dayNumber, int pageIndex, int pageSize) =>
      _getVideosFromUrl('${Api.HOST_URL}:8080/api/birthdays?monthNumber=$monthNumber&dayNumber=$dayNumber&pageIndex=$pageIndex&pageSize=$pageSize');

  Future<BirthdayModel> _getVideosFromUrl(String url) async {

    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.secondToken}',
      },
    );

    if (response.statusCode == 200) {
      return BirthdayModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else if(response.statusCode == 401){
      throw AuthFailure();
    } else {
      Status.code = response.statusCode;
      throw ServerException();
    }
  }
}