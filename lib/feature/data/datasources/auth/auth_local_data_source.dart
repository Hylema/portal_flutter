import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthLocalDataSource {
  saveData();
  saveTokens();
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Storage storage;
  final String cachedNameFirstToken;
  final String cachedNameSecondToken;
  final String cachedNameCurrentUser;

  AuthLocalDataSource({
    @required this.sharedPreferences,
    @required this.storage,
    @required this.cachedNameFirstToken,
    @required this.cachedNameSecondToken,
    @required this.cachedNameCurrentUser,
  });

  @override
  void saveTokens({@required String firstToken, @required String secondToken}) {
    sharedPreferences.setString(cachedNameFirstToken, json.encode(firstToken));
    sharedPreferences.setString(cachedNameSecondToken, json.encode(secondToken));
    ///Декодирование jwt token, может понадобится в будущем
    //await flutterSecureStorage.write(key: JWT_DECODE, value: jsonEncode(Jwt.parseJwt(token)));
  }

  @override
  void saveData({@required CurrentUserModel currentUserModel}) {
    sharedPreferences.setString(cachedNameCurrentUser, json.encode(currentUserModel.toJson()));
  }
}

