import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class PhoneBookUserParams extends Params{
  int pageIndex = 1;
  final int pageSize = PHONE_BOOK_USERS_PAGE_SIZE;
  String departmentCode;
  String searchString;
  bool favoriteOnly;

  PhoneBookUserParams({
    this.departmentCode,
    this.searchString,
    this.favoriteOnly,
  });

  Map toMap(){
    return createParams(map: {
      'departmentCode': departmentCode,
      'searchString': searchString,
      'favoriteOnly': favoriteOnly,
      'pageIndex': pageIndex,
      'pageSize': pageSize,
    });
  }
}