import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/datasources/local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBirthdayLocalDataSource {
  BirthdayModel getBirthdayFromCache();

  Future<void> setBirthdayToCache({@required BirthdayModel model});
}

class BirthdayLocalDataSource extends LocalDataSource<BirthdayModel> implements IBirthdayLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  BirthdayLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  BirthdayModel getBirthdayFromCache() =>
      getDataFromCache(
        cachedName: cachedName,
        model: Model(
          model: BirthdayModel
        )
      );

  @override
  Future<void> setBirthdayToCache({@required BirthdayModel model}) =>
      setDataToCache(
          cachedName: cachedName,
          model: Model(
              model: model
          )
      );
}