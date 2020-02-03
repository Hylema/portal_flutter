import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/token.dart';
import 'package:flutter_architecture_project/feature/data/models/news_portal_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsPortalRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NewsPortalModel> getNewsPortal(int skip, int top);
}

class NewsPortalRemoteDataSourceImpl implements NewsPortalRemoteDataSource {
  final http.Client client;

  NewsPortalRemoteDataSourceImpl({@required this.client});

  @override
  Future<NewsPortalModel> getNewsPortal(int skip, int top) =>
      _getNewsPortalFromUrl("https://metalloinvest.sharepoint.com/Sites/portal/_api/web/lists/GetByTitle('Новости')/items?\$orderby=Created desc&%24skiptoken=Paged%3dTRUE%26p_ID%3d$skip&amp&\$top=$top");

  Future<NewsPortalModel> _getNewsPortalFromUrl(String url) async {
    print('Дошел до метода получения данных, а вот готовый url === $url');
    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthToken.token}'
      },
    );

    print('response.statusCode === ${response.statusCode}');
    print('response.body === ${response.body}');

    if (response.statusCode == 200) {
      return NewsPortalModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}