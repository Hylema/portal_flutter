import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IProfileLocalDataSource {
  ProfileModel getProfileFromCache();

  Future<void> saveProfileToCache({@required ProfileModel model});
}

class ProfileLocalDataSource implements IProfileLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  ProfileLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  ProfileModel getProfileFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    final Map _data = json.decode(jsonString);
    print('_data - -------------------------------- $_data');
    ProfileModel model = ProfileModel.fromJson(_data);
    print('model - -------------------------------- $model');

    return model;
  }

  @override
  Future<void> saveProfileToCache({@required ProfileModel model}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(model.toJson()),
      );
}