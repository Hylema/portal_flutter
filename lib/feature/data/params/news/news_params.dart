import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class NewsParams extends Params{
  int pageIndex;
  int pageSize;

  NewsParams({
    @required this.pageIndex,
    @required this.pageSize,
  });

  @override
  List get props => [pageIndex, pageSize];

  @override
  Map get urlProps => {
    'pageIndex': pageIndex,
    'pageSize': pageSize,
  };
}