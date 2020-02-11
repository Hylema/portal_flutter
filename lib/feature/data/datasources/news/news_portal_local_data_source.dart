import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsPortalLocalDataSource {
  Future<NewsPortalModel> getLastNewsPortal();

  Future<void> cacheNewsPortal(NewsPortalModel triviaToCache);
}

class NewsPortalLocalDataSourceImpl implements NewsPortalLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cachedName = 'CACHED_NEWS_PORTAL';

  NewsPortalLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NewsPortalModel> getLastNewsPortal() {
    final jsonString = sharedPreferences.getString(cachedName);
    if (jsonString != null) {
      return Future.value(NewsPortalModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNewsPortal(NewsPortalModel modelNewsToCache) {
    return sharedPreferences.setString(
      cachedName,
      json.encode(modelNewsToCache.toJson()),
    );
  }
}