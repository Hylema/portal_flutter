import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/data/repositories/polls/polls_repository.dart';
import './bloc.dart';

class PollsBloc extends Bloc<PollsEvent, PollsState> {
  final PollsRepository repository;

  PollsBloc({@required this.repository});

  @override
  PollsState get initialState => InitialPollsState();

  @override
  Stream<PollsState> mapEventToState(
    PollsEvent event,
  ) async* {
    if(event is FetchPastPollsEvent) yield* _fetchPastPolls(event);
    else if(event is FetchCurrentPollsEvent) yield* _fetchCurrentPolls(event);
  }

  Stream<PollsState> _fetchCurrentPolls(FetchCurrentPollsEvent event) async* {
    List<PollsModel> repositoryResult =
    await repository.getCurrentPolls();

    yield LoadedPollsState(listPolls: repositoryResult);
  }

  Stream<PollsState> _fetchPastPolls(PollsEvent event) async* {
    List<PollsModel> repositoryResult =
    await repository.getPastPolls();

    yield LoadedPollsState(listPolls: repositoryResult);
  }
}
