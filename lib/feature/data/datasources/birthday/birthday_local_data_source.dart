import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/datasources/local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBirthdayLocalDataSource {
  BirthdayModel getBirthdayFromCache();

  Future<void> setBirthdayToCache({@required BirthdayModel model});
}

class BirthdayLocalDataSource implements IBirthdayLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  BirthdayLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  BirthdayModel getBirthdayFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    return BirthdayModel.fromJson(json: json.decode(jsonString));
  }

  @override
  Future<void> setBirthdayToCache({@required BirthdayModel model}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(model),
      );
}