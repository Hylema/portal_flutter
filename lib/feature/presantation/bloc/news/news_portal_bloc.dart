import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import './bloc.dart';

class NewsPortalBloc extends Bloc<NewsPortalEvent, NewsPortalState>{

  @override
  NewsPortalState get initialState => EmptyNewsPortal();

  @override
  Stream<NewsPortalState> mapEventToState(
      NewsPortalEvent event,
      ) async* {
    if (event is UpdateNewsEvent) yield* _update(event: event);
    else if(event is FetchNewsEvent) yield* _fetch(event: event);
  }

  _update({@required NewsPortalEvent event}){}

  _fetch({@required NewsPortalEvent event}){}
}

//NEWS_PAGE_SIZE