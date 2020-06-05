import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Params extends Equatable{
  Map<String, String> createParams({@required Map map}){
    Map params = {};

    map.forEach((key, value) {
      if (value != null && value != '') params[key] = '$value';
    });

    return Map<String, String>.from(params);
  }
}