import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalDataSource {

  /// Throws [NoLocalDataException] if no cached data is present.
  Future<ProfileModel> getDataFromCache();

  Future<void> saveDataToCache(ProfileModel modelToCache);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cachedName = 'CACHED_PROFILE';

  ProfileLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<ProfileModel> getDataFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    if (jsonString != null) {
      return Future.value(ProfileModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveDataToCache(ProfileModel modelNewsToCache) {
    return sharedPreferences.setString(
      cachedName,
      json.encode(modelNewsToCache.toJson()),
    );
  }
}