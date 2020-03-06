import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
abstract class IBirthdayRemoteDataSource {

  Future<BirthdayModel> getBirthday({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required int pageSize
  });

}

class BirthdayRemoteDataSource extends RemoteDataSource<BirthdayModel> implements IBirthdayRemoteDataSource {
  Storage storage;

  BirthdayRemoteDataSource({
    @required this.storage,
  });

  @override
  Future<BirthdayModel> getBirthday({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required int pageSize
}) async => await getDataFromNetwork(
      url: '${Api.HOST_URL}:8080/api/birthdays?monthNumber=$monthNumber&dayNumber=$dayNumber&pageIndex=$pageIndex&pageSize=$pageSize',
      token: storage.secondToken,
      model: Model<BirthdayModel>(
          model: BirthdayModel
      )
  );
}