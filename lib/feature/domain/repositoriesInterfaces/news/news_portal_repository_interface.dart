import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/news/like_news_model.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/params/news/news_params.dart';

abstract class INewsPortalRepository {
  Future<List<NewsModel>> fetchNews({@required NewsParams params, bool isUpdate});
  List<NewsModel> getNewsFromCache();
  Future<void> saveNewsToCache({@required List<NewsModel> listModels});
  Future<void> updateNewsCache({@required List<NewsModel> listModels});
  Future<LikeNewsModel> likeNews({@required String guid, @required String id});
  Future<LikeNewsModel> removeLikeNews({@required String guid, @required String id});
}