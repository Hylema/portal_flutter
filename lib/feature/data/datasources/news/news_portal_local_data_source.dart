import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class INewsPortalLocalDataSource {
  List<NewsModel> getNewsFromCache();

  Future<void> saveNewsToCache({@required List<NewsModel> listModels});
  Future<void> updateNewsCache({@required List<NewsModel> listModels});
}

class NewsPortalLocalDataSource implements INewsPortalLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  NewsPortalLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  List<NewsModel> getNewsFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    final List<dynamic> listBirthday = json.decode(jsonString);

    List<NewsModel> listModels = List<NewsModel>.from(listBirthday.map((raw) => NewsModel.fromJson(raw)));

    return listModels;
  }

  @override
  Future<void> saveNewsToCache({@required List<NewsModel> listModels}) {
    List<NewsModel> _listModels = getNewsFromCache();

    return sharedPreferences.setString(
      cachedName,
      json.encode([..._listModels, ...listModels]),
    );
  }

  @override
  Future<void> updateNewsCache({@required List<NewsModel> listModels}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(listModels),
      );
}