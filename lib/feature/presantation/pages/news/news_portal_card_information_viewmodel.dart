import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/likeNews/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class NewsPortalCardInformationViewModel extends BaseViewModel {


  NewsModel news;
  final LikeNewsBloc likeNewsBloc;
  final getIt = GetIt.instance;

  NewsPortalCardInformationViewModel({@required this.news, @required this.likeNewsBloc}){
    final Storage storage = getIt<Storage>();

    likeNewsBloc.listen((state) {
      if(state is LoadedLikesState) {
        news.likesCount = state.likes;
        news.likedBy.add(storage.currentUserModel.id);
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

  ScrollController scrollController = new ScrollController();

  bool show = false;

  void like(String id, String guid) {
    if(news.isLike()) likeNewsBloc.add(removeLikeEvent(guid: guid, id: id));
    else likeNewsBloc.add(likeNewEvent(guid: guid, id: id));
  }
}