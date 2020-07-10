import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class VideoGalleryParams extends Params{
  int pageIndex;
  int pageSize;

  VideoGalleryParams({
    @required this.pageIndex,
    @required this.pageSize,
  });

  @override
  List get props => [pageIndex, pageSize];

  @override
  Map get urlProps => {
    'pageIndex': pageIndex,
    'pageSize': pageSize
  };
}