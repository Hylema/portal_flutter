import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  final SharedPreferences sharedPreferences;
  final String cachedName;
  final model;

  Cache({
    @required this.sharedPreferences,
    @required this.cachedName,
    @required this.model,
  }){
    assert(sharedPreferences != null);
    assert(cachedName != null);
    assert(model != null);
  }

  Future getDataFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    if (jsonString != null) {
      return Future.value(model.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  Future<void> saveDataToCache(modelToCache) {
    return sharedPreferences.setString(
      cachedName,
      json.encode(modelToCache.toJson()),
    );
  }
}