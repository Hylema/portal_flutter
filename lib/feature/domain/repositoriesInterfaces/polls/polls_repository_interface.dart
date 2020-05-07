import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';

abstract class IPollsRepository {
  Future<List<PollsModel>> getCurrentPolls();
  Future<List<PollsModel>> getPastPolls();
}