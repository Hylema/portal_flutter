import 'dart:convert';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';

import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/params/news/news_params.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class INewsPortalRemoteDataSource {

  Future<List<NewsModel>> getNewsWithParams({@required NewsParams params});
}

class NewsPortalRemoteDataSource with ResponseHandler implements INewsPortalRemoteDataSource {
  final http.Client client;
  final Storage storage;

  NewsPortalRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  Future<List<NewsModel>> getNewsWithParams({@required NewsParams params}) async {

    final response = await http.get(
      "https://metalloinvest.sharepoint.com/Sites/portal/_api/web/lists/GetByTitle('Новости')/items?\$orderby=Created desc&%24skiptoken=Paged%3dTRUE%26p_ID%3d${params.skip}&amp&\$top=${params.top}",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return responseHandler<NewsModel>(response: response, model: NewsModel.fromJson, key: 'value');
  }
}