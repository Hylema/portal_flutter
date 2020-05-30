import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/news/like_news_model.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/news/news_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';

import 'package:meta/meta.dart';

class NewsPortalRepository implements INewsPortalRepository{
  final NewsPortalRemoteDataSource remoteDataSource;
  final NewsPortalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsPortalRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<List<NewsModel>> fetchNews({@required NewsParams params, bool isUpdate = false}) async {
    List<NewsModel> listModel =
    await remoteDataSource.getNewsWithParams(params: params);

    if(isUpdate) await updateNewsCache(listModels: listModel);
    else await saveNewsToCache(listModels: listModel);

    return listModel;
  }

  @override
  Future<LikeNewsModel> likeNew({@required String guid, @required String id}) async =>
      await remoteDataSource.likeNew(guid: guid, id: id);

  @override
  Future<LikeNewsModel> removeLikeNew({@required String guid, @required String id}) async =>
      await remoteDataSource.removeLikeNew(guid: guid, id: id);

  @override
  List<NewsModel> getNewsFromCache() =>
      localDataSource.getNewsFromCache();

  @override
  Future<void> saveNewsToCache({@required List<NewsModel> listModels}) async =>
      await localDataSource.saveNewsToCache(listModels: listModels);

  @override
  Future<void> updateNewsCache({@required List<NewsModel> listModels}) async =>
      await localDataSource.updateNewsCache(listModels: listModels);
}