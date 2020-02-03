import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/until/input_converter.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/get_news_portal.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NewsPortalBloc extends Bloc<NewsPortalEvent, NewsPortalState> {
  final GetNewsPortal getNewsPortal;
  final InputConverter inputConverter;

  NewsPortalBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetNewsPortal news,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(news != null),
        assert(inputConverter != null),
        getNewsPortal = news;

  @override
  NewsPortalState get initialState => Empty();

  @override
  Stream<NewsPortalState> mapEventToState(
      NewsPortalEvent event,
      ) async* {
    if (event is GetFirstNewsPortalBloc) {
      final failureOrModel = await getNewsPortal(
        Params(skip: event.skip, top: event.top),
      );
      yield* _eitherLoadedOrErrorState(failureOrModel);

    } else if(event is GetNextNewsPortalBloc){
      yield Loading();
      final failureOrModel = await getNewsPortal(
        Params(skip: event.skip, top: event.top),
      );
      yield* _eitherLoadedOrErrorState(failureOrModel);

    } else if(event is RefreshNewsPortalBloc) {
      yield Loading();
      final failureOrModel = await getNewsPortal(
        Params(skip: event.skip, top: event.top),
      );
      yield* _eitherLoadedOrErrorState(failureOrModel);
    }
  }

  Stream<NewsPortalState> _eitherLoadedOrErrorState(
      Either<Failure, NewsPortal> either,
      ) async* {
    yield either.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (model) => Loaded(model: model),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

