import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/news/like_news_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';
import './bloc.dart';

class LikeNewsBloc extends Bloc<LikeNewsEvent, LikeNewsState> {

  final INewsPortalRepository repository;
  LikeNewsBloc({@required this.repository});

  @override
  LikeNewsState get initialState => InitialLikeNewsState();

  @override
  Stream<LikeNewsState> mapEventToState(
    LikeNewsEvent event,
  ) async* {
    if(event is likeNewEvent) {
      final LikeNewsModel likeModel = await repository.likeNew(guid: event.guid, id: event.id);
      yield LoadedLikesState(likes: likeModel.likeCount, isLike: true);
    } else if(event is removeLikeEvent){
      final LikeNewsModel likeModel = await repository.removeLikeNew(guid: event.guid, id: event.id);
      yield LoadedLikesState(likes: likeModel.likeCount, isLike: false);
    }
  }
}
