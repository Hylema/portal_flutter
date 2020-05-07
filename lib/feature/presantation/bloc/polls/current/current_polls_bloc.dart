import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/polls/polls_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import './bloc.dart';

class CurrentPollsBloc extends Bloc<CurrentPollsEvent, CurrentPollsState> {
  final PollsRemoteDataSource repository;
  final NetworkInfo networkInfo;

  CurrentPollsBloc({@required this.repository, @required this.networkInfo});

  @override
  CurrentPollsState get initialState => EmptyCurrentPolls();

  @override
  Stream<CurrentPollsState> mapEventToState(
    CurrentPollsEvent event,
  ) async* {
    if(await networkInfo.isConnected){
      if (event is FetchCurrentPolls)
        yield* _fetchCurrentPolls(event: event);

    } else {
      throw NetworkException();
    }
  }

  Stream<CurrentPollsState> _fetchCurrentPolls({@required event}) async* {
    List<PollsModel> repositoryResult =
    await repository.getCurrentPolls();

    yield LoadedCurrentPolls(listCurrentPolls: repositoryResult);
  }
}
