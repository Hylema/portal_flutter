import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/datasources/local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBirthdayLocalDataSource {
  List<BirthdayModel> getBirthdayFromCache();

  Future<void> saveBirthdayToCache({@required List<BirthdayModel> listModels});
  Future<void> updateBirthdayCache({@required List<BirthdayModel> listModels});
}

class BirthdayLocalDataSource implements IBirthdayLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  BirthdayLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  List<BirthdayModel> getBirthdayFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    final List<dynamic> listBirthday = json.decode(jsonString);

    List<BirthdayModel> listModels = List<BirthdayModel>.from(listBirthday.map((raw) => BirthdayModel.fromJson(raw)));

    print('listModels =============== $listModels');

    return listModels;
  }

  @override
  Future<void> saveBirthdayToCache({@required List<BirthdayModel> listModels}) {
    List<BirthdayModel> _listModels = getBirthdayFromCache();

    return sharedPreferences.setString(
      cachedName,
      json.encode([..._listModels, ...listModels]),
    );
  }

  @override
  Future<void> updateBirthdayCache({@required List<BirthdayModel> listModels}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(listModels),
      );
}