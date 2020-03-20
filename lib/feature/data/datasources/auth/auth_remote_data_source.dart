import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class IAuthRemoteDataSource {

  Future<String> getFirstToken({
    @required String code
  });

  Future<String> getSecondToken({
    @required String refreshToken
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource({
    @required this.client,
  });

  @override
  Future<String> getFirstToken({String code}) async {
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

    print('auth token ======= ${response.body}');
  }

  @override
  Future<String> getSecondToken({String refreshToken}) async {
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

    print('auth secondToken ======= ${response.body}');

  }
}
