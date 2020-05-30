import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';

import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalState extends Equatable{
  @override
  List<Object> get props => [];
}

class EmptyNewsPortal extends NewsPortalState {}
class LoadingNewsPortal extends NewsPortalState {}
class LoadedNewsPortal extends NewsPortalState {
  final List<NewsModel> listModels;
  final bool hasReachedMax;

  LoadedNewsPortal({@required this.listModels, this.hasReachedMax});

  LoadedNewsPortal copyWith({
    List<NewsModel> birthdays,
    bool hasReachedMax,
  }) {
    return LoadedNewsPortal(
      listModels: listModels ?? this.listModels,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [listModels, hasReachedMax];
}

class ErrorNewsPortal extends NewsPortalState {
  final String message;

  ErrorNewsPortal({@required this.message});
}

class NewsFromCacheState extends NewsPortalState {
  final List<NewsModel> listModels;
  NewsFromCacheState({@required this.listModels});
}

