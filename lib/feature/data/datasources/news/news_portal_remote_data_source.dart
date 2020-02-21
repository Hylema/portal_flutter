import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/status_code.dart';

import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class INewsPortalRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  Future<NewsPortalModel> getNewsPortal(int skip, int top);
}

class NewsPortalRemoteDataSource implements INewsPortalRemoteDataSource {
  final http.Client client;
  Storage storage;

  NewsPortalRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<NewsPortalModel> getNewsPortal(int skip, int top) =>
      _getNewsPortalFromUrl("https://metalloinvest.sharepoint.com/Sites/portal/_api/web/lists/GetByTitle('Новости')/items?\$orderby=Created desc&%24skiptoken=Paged%3dTRUE%26p_ID%3d$skip&amp&\$top=$top");

  Future<NewsPortalModel> _getNewsPortalFromUrl(String url) async {

    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}'
      },
    );

    if (response.statusCode == 200) {
      return NewsPortalModel.fromJson(json.decode(response.body));
    } else if(response.statusCode == 401){
      throw AuthFailure();
    } else {
      Status.code = response.statusCode;
      throw ServerException();
    }
  }
}