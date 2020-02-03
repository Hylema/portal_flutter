import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/get_news_portal.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {

  final GetNewsPortal getNewsPortal;

  BirthdayBloc({
    @required GetNewsPortal news,
  })  : assert(news != null),
        getNewsPortal = news;

  @override
  BirthdayState get initialState => Emptyy();

  @override
  Stream<BirthdayState> mapEventToState(
    BirthdayEvent event,
  ) async* {
    if (event is GetBirthdayEventBloc) {
      final failureOrModel = await getNewsPortal(
        Params(skip: event.skip, top: event.top),
      );
      yield* _eitherLoadedOrErrorState(failureOrModel);

    }
  }

  Stream<BirthdayState> _eitherLoadedOrErrorState(
      Either<Failure, NewsPortal> either,
      ) async* {
    yield either.fold(
          (failure) => Errorr(message: _mapFailureToMessage(failure)),
          (model) => Loadedd(model: model),
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
