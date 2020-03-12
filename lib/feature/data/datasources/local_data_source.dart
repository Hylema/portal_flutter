//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class LocalDataSource<Type> {
//  final SharedPreferences sharedPreferences;
//
//  LocalDataSource({@required this.sharedPreferences});
//
//  Type getDataFromCache({
//    @required model,
//    @required String cachedName
//  }){
//    final jsonString = sharedPreferences.getString(cachedName);
//    return model(json: json.decode(jsonString));
//  }
//
//  Future<void> setDataToCache({
//    @required String cachedName,
//    @required model,
//  }){
//    return sharedPreferences.setString(
//      cachedName,
//      json.encode(model),
//    );
//  }
//}