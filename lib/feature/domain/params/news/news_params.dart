import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/domain/params/params.dart';

class NewsParams extends Params{
  int pageIndex;
  int pageSize;

  NewsParams({
    @required this.pageIndex,
    @required this.pageSize,
  });

  Map toMap(){
    return createParams(map: {
      'pageIndex': pageIndex,
      'pageSize': pageSize,
    });
  }
}