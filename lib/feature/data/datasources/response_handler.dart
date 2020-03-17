import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';

class ResponseHandler<Type> {

  List<BirthdayModel> responseHandler({@required response, @required model}){
    switch(response.statusCode){
      case 200 :
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        final raws = data['data'] as List;

        List<BirthdayModel> list = raws.map((raw) {
          return BirthdayModel.fromJson(raw);
        }).toList();

        print('list =========== ${list.runtimeType}');

        return list;

        break;
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(); break;
      default: throw UnknownException(
          code: response.statusCode
      );
    }
  }

  Map<String, String> createParams({@required Map map}){
    Map params = {};

    map.forEach((key, value) {
      if (value != null && value != '') params[key] = '$value';
    });

    return Map<String, String>.from(params);
  }
}
