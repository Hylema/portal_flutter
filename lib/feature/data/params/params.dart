import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Params extends Equatable{

  Map urlProps;
  Map bodyProps;

  Map<String, String> toUrlParams() {
    Map<String, String> map = new Map();

    urlProps.forEach((key, value) {
      if(value != null && value != ''){
        map[key] = '$value';
      }
    });

    return map;
  }

  String toBodyParams() {
    Map map = new Map();

    bodyProps.forEach((key, value) {
      if(value != null && value != ''){
        map[key] = value;
      }
    });

    return jsonEncode(map);
  }
}