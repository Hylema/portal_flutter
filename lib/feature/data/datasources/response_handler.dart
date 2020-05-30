import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';

class ResponseHandler {

  Type model<Type>({@required response, @required model, String key}){
    if(response.statusCode != 200) _throwError(statusCode: response.statusCode);

    final _data = jsonDecode(utf8.decode(response.bodyBytes));
    var _raw;

    if(key != null) _raw = _data[key];
    else _raw = _data;

    Type result = model(_raw);

    return result;
  }

  List<Type> listModels<Type>({@required response, @required model, @required String key}){
    if(response.statusCode != 200) return _throwError(statusCode: response.statusCode);

    final _data = jsonDecode(utf8.decode(response.bodyBytes));
    final _raws = _data[key] as List;

    List<Type> _listModels = List<Type>.from(_raws.map((raw) => model(raw)));

    return _listModels;
  }

  _throwError({@required statusCode}){
    switch(statusCode){
      case 400 : throw BadRequestException(); break;
      case 401 : throw AuthException(); break;
      case 500 : throw ServerException(); break;
      default: throw UnknownException(
          code: statusCode
      );
    }
  }
}
