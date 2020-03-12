import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';

class ResponseHandler<Type> {

  Type responseHandler({@required response, @required model}){
    switch(response.statusCode){
      case 200 : return model(json: jsonDecode(utf8.decode(response.bodyBytes))); break;
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(); break;
      default: throw UnknownException(
          code: response.statusCode
      );
    }
  }
}
