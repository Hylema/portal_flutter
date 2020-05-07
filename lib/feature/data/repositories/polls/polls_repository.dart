import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/polls/polls_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/polls/polls_repository_interface.dart';

import 'package:meta/meta.dart';

class PollsRepository implements IPollsRepository{
  final PollsRemoteDataSource remoteDataSource;
  //final NewsPortalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PollsRepository({
    @required this.remoteDataSource,
    //@required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<List<PollsModel>> getCurrentPolls() async {
    List<PollsModel> listModel =
    await remoteDataSource.getCurrentPolls();

    ///save

    return listModel;
  }

  @override
  Future<List<PollsModel>> getPastPolls() async {
    List<PollsModel> listModel =
    await remoteDataSource.getPastPolls();

    ///save

    return listModel;
  }
}