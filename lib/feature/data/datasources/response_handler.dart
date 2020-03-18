import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';

class ResponseHandler<Type> {

  List<Type> responseHandler({@required response, @required model}){
    switch(response.statusCode){
      case 200 :
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        final raws = data['data'] as List;

        List<Type> listModel = List<Type>.from(raws.map((raw) => model(raw)));

        return listModel;

        break;
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(
        message: 'Ошибка сервера, статус код 500'
      ); break;
      default: throw UnknownException(
          code: response.statusCode
      );
    }
  }
}
