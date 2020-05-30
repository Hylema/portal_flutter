import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences sharedPreferences;
  final String cachedNameFirstToken;
  final String cachedNameSecondToken;
  final String cachedNameCurrentUser;

  Storage({
    @required this.sharedPreferences,
    @required this.cachedNameFirstToken,
    @required this.cachedNameSecondToken,
    @required this.cachedNameCurrentUser,
  }){}

  String get token => _getData(cachedNameFirstToken);
  String get secondToken => _getData(cachedNameSecondToken);
  CurrentUserModel get currentUserModel {
    return CurrentUserModel.fromJson([_getData(cachedNameCurrentUser)]);
  }

  dynamic _getData(String cacheName){
    final cache = sharedPreferences.getString(cacheName);
    if(cache == null) return cache;
    else return json.decode(cache);
  }
}