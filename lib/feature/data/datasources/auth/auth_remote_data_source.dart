import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/first_token_model.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/second_token_model.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:http/http.dart' as http;

abstract class IAuthRemoteDataSource {

  Future<FirstTokenModel> getFirstToken({
    @required String code
  });

  Future<SecondTokenModel> getSecondToken({
    @required String refreshToken
  });

  Future<AuthState> checkAuth();

  Future<CurrentUserModel> getCurrentUser({@required String email});
}

class AuthRemoteDataSource with ResponseHandler implements IAuthRemoteDataSource {
  final http.Client client;
  final Storage storage;

  AuthRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<FirstTokenModel> getFirstToken({String code}) async {
    String uri = 'https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/token';

    final response = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'client_id': '0cf3f177-6d32-440c-a4e2-08cc84dbc3bb',
        'redirect_uri': 'https://mi-portal.azurewebsites.net',
        'grant_type': 'authorization_code',
        'client_secret': '+wGQ_wz0?:mjvHsgWIF76DR3Imn+*vtG',
        'code': code
      }
    );

    return FirstTokenModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<SecondTokenModel> getSecondToken({String refreshToken}) async {
    String uri = 'https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/token';

    final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'client_id': '0cf3f177-6d32-440c-a4e2-08cc84dbc3bb',
          'redirect_uri': 'https://mi-portal.azurewebsites.net',
          'grant_type': 'refresh_token',
          'client_secret': '+wGQ_wz0?:mjvHsgWIF76DR3Imn+*vtG',
          'resource': '0cf3f177-6d32-440c-a4e2-08cc84dbc3bb',
          'refresh_token': refreshToken
        }
    );

    return SecondTokenModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<AuthState> checkAuth() async {

    final response = await client.get(
      Api.GET_PROFILE_URL,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}'
      },
    );

    switch(response.statusCode){
      case 200: return AuthCompletedState(); break;
      case 401: return NeedAuthState(); break;
      default: return AuthFailedState();
    }
  }

  @override
  Future<CurrentUserModel> getCurrentUser({@required String email}) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/users/info', {
      'email': email
    }).toString();

    final response = await client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}'
      },
    );

    return model<CurrentUserModel>(response: response, model: CurrentUserModel.fromJson, key: 'data');
  }

}
