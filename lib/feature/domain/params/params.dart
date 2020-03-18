import 'package:flutter/cupertino.dart';

class Params {
  Map<String, String> createParams({@required Map map}){
    Map params = {};

    map.forEach((key, value) {
      if (value != null && value != '') params[key] = '$value';
    });

    return Map<String, String>.from(params);
  }
}