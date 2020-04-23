import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
abstract class IMainParamsJsonDataSource {
  Future<void> setToCache({@required List positionPages});
  List getFromCache();
}

class MainParamsJsonDataSource implements IMainParamsJsonDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  MainParamsJsonDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  List getFromCache() {
    try {
      final jsonString = sharedPreferences.getString(cachedName);
      final List<dynamic> listPositionPages = json.decode(jsonString);

      return listPositionPages;
    } catch(e){
      final String path = 'assets/icons/';
      final defaultPositionPages = [
        {
          'name': 'Новости',
          'status': true,
          'icon': '${path}news.png'
        },
        {
          'name': 'Опросы',
          'status': true,
          'icon': '${path}polls.png'
        },
        {
          'name': 'Видеогалерея',
          'status': true,
          'icon': '${path}videoGallery.png'
        },
        {
          'name': 'Дни рождения',
          'status': false,
          'icon': '${path}birthday.png',
        },
        {
          'name': 'Бронирование переговорных',
          'status': false,
          'icon': '${path}negotiationReservation.png'
        },
      ];

      setToCache(positionPages: defaultPositionPages);

      return defaultPositionPages;
    }
  }

  Future<void> setToCache({@required List positionPages}) =>
      sharedPreferences.setString(
        cachedName,
        json.encode(positionPages),
      );
}