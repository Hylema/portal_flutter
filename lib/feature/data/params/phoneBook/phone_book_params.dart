import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class PhoneBookParams extends Params{
  String parentCode;

  PhoneBookParams({
    @required this.parentCode,
  });

  Map toMap(){
    return createParams(map: {
      'parentCode': parentCode,
    });
  }
}