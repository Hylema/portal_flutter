import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class IProfileRemoteDataSource {

  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSource with ResponseHandler implements IProfileRemoteDataSource {
  final http.Client client;
  final Storage storage;

  ProfileRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<ProfileModel> getProfile() async {

    final response = await client.get(
      Api.GET_PROFILE_URL,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}'
      },
    );

    return model<ProfileModel>(response: response, model: ProfileModel.parsData);
  }
}