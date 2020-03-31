import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/first_token_model.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/second_token_model.dart';
import 'package:http/http.dart' as http;

abstract class IAuthRemoteDataSource {

  Future<FirstTokenModel> getFirstToken({
    @required String code
  });

  Future<SecondTokenModel> getSecondToken({
    @required String refreshToken
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource({
    @required this.client,
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
}
