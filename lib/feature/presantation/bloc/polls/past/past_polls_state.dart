import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PastPollsState {}

class EmptyPastPolls extends PastPollsState {}
class LoadedPastPolls extends PastPollsState {
  List<PollsModel> listPastPolls;

  LoadedPastPolls({this.listPastPolls});
}
class LoadingPastPolls extends PastPollsState {}
