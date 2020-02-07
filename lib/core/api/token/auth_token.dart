import 'dart:io';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/api/token/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AuthToken {

  final constants = {
    'grant_type': 'authorization_code',
    'client_id': '0cf3f177-6d32-440c-a4e2-08cc84dbc3bb',
    'redirect_uri': 'https://mi-portal.azurewebsites.net',
    'client_secret': '+wGQ_wz0?:mjvHsgWIF76DR3Imn+*vtG'
  };

  final String jsonPath = '/assets/token.json';

  Future getTokenFromFile() async {
    var file = await this.readFile();
    print('file[token]--------------------------------------------------------------------- === ${file['token']}');

    Token.authToken = file['token'];
  }

  AuthToken(){
     getTokenFromFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    try {
      final path = await _localPath;
      return File('$path/token.json');
    } catch(e){
      await writeFile('123');

      final path = await _localPath;
      return File('$path/token.json');
    }
  }

  Future readFile() async {
    final file = await _localFile;

    return jsonDecode(file.readAsStringSync());
  }

  Future writeFile(String token) async {
    final file = await _localFile;
    assert(token != null);
    Token.authToken = token;
    return file.writeAsString(jsonEncode({
      'token': token
    }));
  }

  Future getTokenFromNetwork(String code) async{
    await http.post(Api.GET_TOKEN_URL, body: {
      ...constants,
      'code': code
    }).then((response) {
      var token = jsonDecode(response.body);

      if(token['access_token'] != null) writeFile(token['access_token']);
      else {
        print('access_token == ${token['access_token']}');
        throw new Exception('access_token == ${token['access_token']}');
      }
    });
  }
}

