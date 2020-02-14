import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/token/token.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/status_code.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class IProfileRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  final http.Client client;
  final ProfileParser parser;

  ProfileRemoteDataSource({
    @required this.client,
    @required this.parser,
  });

  @override
  Future<ProfileModel> getProfile() =>
      _getProfileFromUrl("https://metalloinvest.sharepoint.com/sites/portal/oemk/_api//SP.UserProfiles.PeopleManager/GetMyProperties");

  Future<ProfileModel> _getProfileFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.authToken}'
      },
    );

    if (response.statusCode == 200) {
      final profile = parser.parsData(response.body);
      return ProfileModel.fromJson(profile);
    } else if(response.statusCode == 401){
      throw AuthFailure();
    } else {
      Status.code = response.statusCode;
      throw ServerException();
    }
  }
}