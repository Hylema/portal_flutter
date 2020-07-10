import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';

class NewsPortalLikeSeenWidgetViewModel extends BaseViewModel {

  final int index;
  final NewsModel news;
  final NewsPortalBloc newsBloc;
  NewsPortalLikeSeenWidgetViewModel({
    @required this.news,
    @required this.newsBloc,
    @required this.index
  }){
    isLikeNow = news.isLike();
    _likeCount = news.likesCount.toString();
  }

  String _likeCount;
  int get likeCount => int.parse(_likeCount);

  bool actionIn = false;
  bool isLikeNow;

  Timer _debounce;

  void like(String id, String guid) {
    if(news.isLike()) newsBloc.add(RemoveLikeEvent(guid: guid, id: id, index: index));
    else newsBloc.add(LikeNewsEvent(guid: guid, id: id, index: index));
  }

  void likeIt() {
    isLikeNow = !isLikeNow;
    actionIn = true;

    if(isLikeNow) _likeCount = (likeCount + 1).toString();
    else _likeCount = (likeCount - 1).toString();

    notifyListeners();

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if(news.isLike() != isLikeNow) like(news.id, news.guid);
    });
  }
}