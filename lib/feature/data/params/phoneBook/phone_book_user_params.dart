import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class PhoneBookUserParams extends Params{
  int pageIndex;
  int pageSize;
  String departmentCode;

  PhoneBookUserParams({
    @required this.pageIndex,
    @required this.pageSize,
    @required this.departmentCode,
  });

  Map toMap(){
    return createParams(map: {
      'pageIndex': pageIndex,
      'pageSize': pageSize,
      'departmentCode': departmentCode,
    });
  }
}