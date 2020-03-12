import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/get_news_popularity_by_id.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/loading_news_popularity_from_network.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/set_user_see_page.dart';
import './bloc.dart';

class NewsPopularityBloc extends Bloc<NewsPopularityEvent, NewsPopularityState> with BlocHelper<NewsPopularityState>{
  final GetNewsPopularityById _getNewsPopularityById;
  final LoadingNewsPopularityFromNetwork _loadingNewsPopularityFromNetwork;
  final SetUserSeePage _setUserSeePage;

  NewsPopularityBloc({
    @required GetNewsPopularityById getNewsPopularityById,
    @required SetUserSeePage setUserSeePage,
    @required LoadingNewsPopularityFromNetwork loadingNewsPopularityFromNetwork,
  }) :  assert(getNewsPopularityById != null),
        assert(loadingNewsPopularityFromNetwork != null),
        assert(setUserSeePage != null),
        _getNewsPopularityById = getNewsPopularityById,
        _loadingNewsPopularityFromNetwork = loadingNewsPopularityFromNetwork,
        _setUserSeePage = setUserSeePage;

  @override
  NewsPopularityState get initialState => EmptyNewsPopularityState();

  @override
  Stream<NewsPopularityState> mapEventToState(
    NewsPopularityEvent event,
  ) async* {
    if (event is GetNewsPopularityEvent) {

      yield LoadingNewsPopularity();

      yield* _eitherLoadedOrErrorState(
          either: await _getNewsPopularityById(
            NewsPopularityParams(id: event.id),
          )
      );
    } else if(event is LoadingPopularityEvent) {
      yield* _eitherLoadedOrErrorState(either: await _loadingNewsPopularityFromNetwork(NoParams()));
    }
  }

  Stream<NewsPopularityState> _eitherLoadedOrErrorState({
    Either either,
  }) async* {
    yield either.fold(
          (failure){
        return ErrorNewsPopularity(message: mapFailureToMessage(failure));
      },
          (model){
        return LoadedNewsPopularity(model: model);
      },
    );
  }
}
