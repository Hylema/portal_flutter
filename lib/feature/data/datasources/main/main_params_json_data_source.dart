import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
abstract class IMainParamsJsonDataSource {
  Future<void> setToCache({@required MainParamsModel model});
  MainParamsModel getFromCache();
}

class MainParamsJsonDataSource implements IMainParamsJsonDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  MainParamsJsonDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  MainParamsModel getFromCache() {
    try {
      final jsonString = sharedPreferences.getString(cachedName);
      final List<dynamic> listPositionPages = json.decode(jsonString);

      return MainParamsModel(params: listPositionPages);
    } catch(e){
      final model = MainParamsModel(params: DEFAULT_POSITION_PAGES);
      setToCache(model: model);
      return model;
    }
  }

  Future<void> setToCache({@required MainParamsModel model}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(model.params),
      );
}