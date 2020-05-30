import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/news/news_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class NewsPortalBloc extends Bloc<NewsPortalEvent, NewsPortalState>{

  final INewsPortalRepository repository;
  final NetworkInfo networkInfo;

  NewsPortalBloc({@required this.repository, @required this.networkInfo});

  @override
  NewsPortalState get initialState => _initialState();

  NewsPortalState _initialState() {
    try {
      List<NewsModel> listModels = repository.getNewsFromCache();

      return NewsFromCacheState(listModels: listModels);
    } catch(e){
      return NewsFromCacheState(listModels: []);
    }
  }

  NewsParams _params = NewsParams(pageSize: NEWS_PAGE_SIZE, pageIndex: 1);

  @override
  Stream<NewsPortalState> mapEventToState(
      NewsPortalEvent event,
      ) async* {
    final currentState = state;

    if(await networkInfo.isConnected){
      if (event is UpdateNewsEvent)
        yield* _update(event: event);

      else if(event is FetchNewsEvent && !_hasReachedMax(currentState))
        yield* _fetch(event: event);
    } else {
      throw NetworkException();
    }
  }

  Stream<NewsPortalState> _update({@required NewsPortalEvent event}) async*{
    _params.pageIndex = 1;

    List<NewsModel> repositoryResult =
    await repository.fetchNews(params: _params, isUpdate: true);

    yield LoadedNewsPortal(listModels: repositoryResult, hasReachedMax: false);
  }

  Stream<NewsPortalState> _fetch({@required NewsPortalEvent event}) async* {
    final currentState = state;

    _params.pageIndex += 1;

    if(currentState is LoadedNewsPortal){
      List<NewsModel> repositoryResult =
      await repository.fetchNews(params: _params);

      yield repositoryResult.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedNewsPortal(
        listModels: currentState.listModels + repositoryResult,
        hasReachedMax: false,
      );
    }
  }

  bool _hasReachedMax(NewsPortalState state) =>
      state is LoadedNewsPortal && state.hasReachedMax;
}

//NEWS_PAGE_SIZE