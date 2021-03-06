import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';

class NewsPortalCardInformationViewModel extends BaseViewModel {

  NewsModel news;
  final NewsPortalBloc newsBloc;

  NewsPortalCardInformationViewModel({@required this.news, @required this.newsBloc}){

    newsBloc.listen((state) {
      if(state is LoadedNewsPortal) {
        notifyListeners();
      }
    });

    scrollController.addListener(() {
      if(show){
        if (scrollController.offset.ceil() < 300) {
          show = false;
          notifyListeners();
        }
      } else {
        if (scrollController.offset.ceil() >= 300) {
          show = true;
          notifyListeners();
        }
      }
    });
  }

  Storage storage;
  ScrollController scrollController = ScrollController();
  bool show = false;
}