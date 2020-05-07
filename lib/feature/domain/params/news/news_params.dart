import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/domain/params/params.dart';

class NewsParams extends Params{
  int skip;
  int top;

  NewsParams({
    @required this.skip,
    @required this.top,
  });

  Map toMap(){
    return createParams(map: {
      'skip': skip,
      'top': top,
    });
  }
}