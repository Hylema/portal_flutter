import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBirthdayLocalDataSource {
  BirthdayResponse getBirthdayFromCache();

  Future<void> saveBirthdayToCache({@required BirthdayResponse response});
  Future<void> updateBirthdayCache({@required BirthdayResponse response});
}

class BirthdayLocalDataSource implements IBirthdayLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  BirthdayLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  BirthdayResponse getBirthdayFromCache() {
    final jsonString = sharedPreferences.getString(cachedName);
    final Map listBirthday = json.decode(jsonString);

    List<BirthdayModel> listModels = List<BirthdayModel>.from(listBirthday['listModels'].map((raw) => BirthdayModel.fromJson(raw)));

    return BirthdayResponse(listModels: listModels, title: listBirthday['title']);
  }

  @override
  Future<void> saveBirthdayToCache({@required BirthdayResponse response}) {
    BirthdayResponse _response = getBirthdayFromCache();

    BirthdayResponse _newModel = new BirthdayResponse(
      listModels: [..._response.listModels, ...response.listModels],
      title: _response.title
    );

    return sharedPreferences.setString(
      cachedName,
      json.encode(_newModel.toJson()),
    );
  }

  @override
  Future<void> updateBirthdayCache({@required BirthdayResponse response}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(response.toJson()),
      );
}