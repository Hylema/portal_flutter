import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/news/news_params.dart';

abstract class INewsPortalRepository {
  Future<List<NewsModel>> fetchNews({@required NewsParams params});
  Future<List<NewsModel>> updateNews({@required NewsParams params});
  List<NewsModel> getNewsFromCache();
  Future<void> saveNewsToCache({@required List<NewsModel> listModels});
  Future<void> updateNewsCache({@required List<NewsModel> listModels});
}