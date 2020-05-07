import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CurrentPollsState {}

class EmptyCurrentPolls extends CurrentPollsState {}
class LoadedCurrentPolls extends CurrentPollsState {
  List<PollsModel> listCurrentPolls;

  LoadedCurrentPolls({this.listCurrentPolls});
}
class LoadingCurrentPolls extends CurrentPollsState {}
