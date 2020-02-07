import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/core/token.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final ProfileParser parser;

  ProfileRemoteDataSourceImpl({@required this.client, @required this.parser});

  @override
  Future<ProfileModel> getProfile() =>
      _getProfileFromUrl("https://metalloinvest.sharepoint.com/sites/portal/oemk/_api//SP.UserProfiles.PeopleManager/GetMyProperties");

  Future<ProfileModel> _getProfileFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthToken.token}'
      },
    );

    print('response.statusCode === ${response.statusCode}');
    print('response.body === ${response.body}');

    if (response.statusCode == 200) {
      final profile = parser.parsData(response.body);
      return ProfileModel.fromJson(profile);
    } else if(response.statusCode == 401){
      throw AuthFailure();
    } else {
      throw ServerException();
    }
  }
}