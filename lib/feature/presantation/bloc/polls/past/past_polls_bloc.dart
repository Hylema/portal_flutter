import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/polls/polls_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import './bloc.dart';

class PastPollsBloc extends Bloc<PastPollsEvent, PastPollsState> {
  final PollsRemoteDataSource repository;
  final NetworkInfo networkInfo;

  PastPollsBloc({@required this.repository, @required this.networkInfo});

  @override
  PastPollsState get initialState => EmptyPastPolls();

  @override
  Stream<PastPollsState> mapEventToState(
    PastPollsEvent event,
  ) async* {
    if(event is FetchPastPolls)
      yield* _fetchPastPolls(event: event);
  }

  Stream<PastPollsState> _fetchPastPolls({@required event}) async* {
    List<PollsModel> repositoryResult =
    await repository.getPastPolls();

    yield LoadedPastPolls(listPastPolls: repositoryResult);
  }
}
