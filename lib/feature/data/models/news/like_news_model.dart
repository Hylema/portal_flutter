import 'package:flutter/cupertino.dart';

class LikeNewsModel {

  final int likeCount;
  LikeNewsModel({@required this.likeCount});

  static LikeNewsModel fromJson(raw) {
    int result;

    if(raw[0] != null) result = raw[0];
    else result = 0;

    return LikeNewsModel(
      likeCount: result,
    );
  }

  List toJson() {
    return [likeCount];
  }
}