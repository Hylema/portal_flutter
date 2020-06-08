import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params_response.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IPhoneBookLocalDataSource {
  List<PhoneBookModel> getPhoneBooksFromCache(String code);
  List<PhoneBookUserModel> getPhoneBooksUserFromCache(String code);

  Future<void> savePhoneBooksToCache({@required String code, @required List listPhoneBooksOrUsers});
  Future<void> updatePhoneBooksCache();
}

class PhoneBookLocalDataSource implements IPhoneBookLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  PhoneBookLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  List<PhoneBookModel> getPhoneBooksFromCache(String code) {
    final Map codes = _getMapObject();
    if(codes[code] == null) return null;

    final List<PhoneBookModel> listModels = List<PhoneBookModel>.from(codes[code].map((raw) => PhoneBookModel.fromJson(raw)));

    return listModels;
  }

  @override
  List<PhoneBookUserModel> getPhoneBooksUserFromCache(String code) {
    final Map codes = _getMapObject();
    if(codes[code] == null) return null;

    final List<PhoneBookUserModel> listModels = List<PhoneBookUserModel>.from(codes[code].map((raw) => PhoneBookUserModel.fromJson(raw)));

    return listModels;
  }

  @override
  Future<void> savePhoneBooksToCache({@required String code, @required List listPhoneBooksOrUsers}) {
    final Map codes = _getMapObject();

    codes[code] = listPhoneBooksOrUsers;

    return sharedPreferences.setString(
      cachedName,
      json.encode(codes),
    );
  }

  @override
  Future<void> updatePhoneBooksCache() =>
      sharedPreferences.setString(
        cachedName,
        json.encode({}),
      );

  Map _getMapObject() {
    final jsonString = sharedPreferences.getString(cachedName);
    if(jsonString == null) return {};

    final Map phoneBooksCodes = json.decode(jsonString);

    return phoneBooksCodes;
  }
}