import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_network.dart';
import './bloc.dart';

class NewsPortalBloc extends Bloc<NewsPortalEvent, NewsPortalState> {
  final GetNewsPortalFormNetwork getNewsFromNetwork;
  final GetNewsPortalFromCache getNewsFromCache;
  int skiped;
  int top;

  NewsPortalBloc({
    @required GetNewsPortalFormNetwork getNewsFromNetwork,
    @required GetNewsPortalFromCache getNewsFromCache,
  }) :  assert(getNewsFromNetwork != null),
        assert(getNewsFromCache != null),
        getNewsFromNetwork = getNewsFromNetwork,
        getNewsFromCache = getNewsFromCache;

  @override
  NewsPortalState get initialState => EmptyNewsPortal();

  @override
  Stream<NewsPortalState> mapEventToState(
      NewsPortalEvent event,
      ) async* {
    if (event is GetNewsPortalFromNetworkBlocEvent) {
      skiped = event.skip;
      top = event.top;

      yield LoadingNewsPortal();
      yield* _eitherLoadedOrErrorState(either: await _getNewsFromNetwork());

    } else if(event is GetNewsPortalFromCacheBlocEvent){
      skiped = event.skip;
      top = event.top;
      yield LoadingNewsPortal();

      var modelOrFailure = await _failureOrModelCache(
        either: await _getNewsFromCache(),
      );

      yield modelOrFailure.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthNews();
          }
          return ErrorNewsPortal(message: mapFailureToMessage(failure));
        },
            (model){
          return LoadedNewsPortal(model: model);
        },
      );
    }
  }

  _getNewsFromCache() async {
    return await getNewsFromCache(
        NoParams()
    );
  }

  _getNewsFromNetwork() async{
    return await getNewsFromNetwork(
      NewsParams(skip: skiped, top: top),
    );
  }

  Stream<NewsPortalState> _eitherLoadedOrErrorState({
    Either<Failure, NewsPortal> either,
  }) async* {
    yield either.fold(
          (failure){
        if(failure is AuthFailure){
          return NeedAuthNews();
        }
        return ErrorNewsPortal(message: mapFailureToMessage(failure));
      },
          (model){
        return LoadedNewsPortal(model: model);
      },
    );
  }

  _failureOrModelCache({
    Either<Failure, NewsPortal> either,
  }) async {
    return either.fold(
          (failure) async {
            return await _getNewsFromNetwork();
          },
          (model){
            return Right(model);
          },
    );
  }
}

