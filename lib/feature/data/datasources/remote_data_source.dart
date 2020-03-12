//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/core/error/exceptions.dart';
//import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
//import 'package:flutter_architecture_project/feature/data/models/model.dart';
//import 'package:http/http.dart' as http;
//
//abstract class IRemoteDataSource {
//
//  Future getDataFromNetwork({
//    @required String url,
//    @required token,
//    @required model
//  });
//}
//
//class RemoteDataSource<Type> implements IRemoteDataSource{
//  final http.Client client;
//
//  RemoteDataSource({
//    @required this.client,
//  });
//
//  @override
//  Future<Type> getDataFromNetwork({
//    @required String url,
//    @required token,
//    @required model
//  }) async {
//    final response = await http.get(
//      url,
//      headers: {
//        'Accept': 'application/json',
//        'Authorization': 'Bearer $token',
//      },
//    );
//  }
//
//}