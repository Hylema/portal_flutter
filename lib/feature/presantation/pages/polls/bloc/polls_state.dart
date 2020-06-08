import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PollsState {}

class InitialPollsState extends PollsState {}

class LoadedPollsState extends PollsState {
  final List<PollsModel> listPolls;

  LoadedPollsState({this.listPolls});
}
class LoadingPollsState extends PollsState {}