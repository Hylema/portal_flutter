import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource<Type> {
  final SharedPreferences sharedPreferences;

  LocalDataSource({@required this.sharedPreferences});

  Type getDataFromCache({
    @required Model model,
    @required String cachedName
  }){
    final jsonString = sharedPreferences.getString(cachedName);
    return model.fromJson(json.decode(jsonString));
  }

  Future<void> setDataToCache({
    @required String cachedName,
    @required Model model,
  }){
    return sharedPreferences.setString(
      cachedName,
      json.encode(model.toJson()),
    );
  }
}