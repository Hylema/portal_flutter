import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/news/like_news_model.dart';

import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/params/news/news_params.dart';
import 'package:http/http.dart' as http;

abstract class INewsPortalRemoteDataSource {

  Future<List<NewsModel>> getNewsWithParams({@required NewsParams params});
  Future<LikeNewsModel> likeNew({@required String guid, @required String id});
  Future<LikeNewsModel> removeLikeNew({@required String guid, @required String id});
}

class NewsPortalRemoteDataSource with ResponseHandler implements INewsPortalRemoteDataSource {
  final http.Client client;
  final Storage storage;

  NewsPortalRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<List<NewsModel>> getNewsWithParams({@required NewsParams params}) async {

    String uri = Uri.http('${Api.HOST_URL}', '/api/news', params.toMap()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<NewsModel>(response: response, model: NewsModel.fromJson, key: 'data');
  }

  @override
  Future<LikeNewsModel> likeNew({@required String guid, @required String id}) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/likes').toString();

    final response = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
      body: jsonEncode({
        'id': id,
        'guid': guid,
      })
    );

    return model<LikeNewsModel>(response: response, model: LikeNewsModel.fromJson, key: 'data');
  }

  @override
  Future<LikeNewsModel> removeLikeNew({@required String guid, @required String id}) async {
    Uri uri = Uri.http('${Api.HOST_URL}', '/api/likes', {
      'id': id,
      'guid': guid
    });

    final request = http.Request("DELETE", uri);
    request.headers.addAll(<String, String>{
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': 'Bearer ${storage.token}',
    });
    request.body = jsonEncode({
      'id': id,
      'guid': guid,
    });
    final http.StreamedResponse response = await request.send();

//    final response = await http.delete(
//        uri,
//        headers: {R
//          'Accept': 'application/json',
//          'Authorization': 'Bearer ${storage.token}',
//        },
//    );

    return LikeNewsModel.fromJson(jsonDecode(await response.stream.bytesToString()));
  }
}