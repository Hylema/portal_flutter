import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';

class ResponseHandler {

  List<Type> responseHandler<Type>({@required response, @required model, @required String key}){
    switch(response.statusCode){
      case 200 :
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        final raws = data[key] as List;

        List<Type> listModels = List<Type>.from(raws.map((raw) => model(raw)));

        return listModels;

        break;
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(); break;
      default: throw UnknownException(
          code: response.statusCode
      );
    }
  }
}
