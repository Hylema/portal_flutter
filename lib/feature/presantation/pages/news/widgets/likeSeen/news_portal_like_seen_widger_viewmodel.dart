import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';

class NewsPortalLikeSeenWidgetViewModel extends BaseViewModel {

  final NewsModel news;
  final Function likeFunc;
  final NewsPortalBloc newsBloc;
  NewsPortalLikeSeenWidgetViewModel({@required this.news, @required this.likeFunc, @required this.newsBloc}){
    isLikeNow = news.isLike();
    _likeCount = news.likesCount.toString();

//    newsBloc.listen((state) {
//      if(state is LoadedNewsPortal){
//        actionIn = false;
//
//        notifyListeners();
//      }
//    });
  }

  String _likeCount;
  int get likeCount => int.parse(_likeCount);

  bool actionIn = false;
  bool isLikeNow;

  Timer _debounce;

  void likeIt() {
    isLikeNow = !isLikeNow;
    actionIn = true;

    if(isLikeNow) _likeCount = (likeCount + 1).toString();
    else _likeCount = (likeCount - 1).toString();

    notifyListeners();

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if(news.isLike() != isLikeNow) likeFunc(news.id, news.guid);
    });
  }
}