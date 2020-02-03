import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPortalCupertinoIndicator extends StatelessWidget {
  final bool cupertinoIndicator;
  NewsPortalCupertinoIndicator({this.cupertinoIndicator});

  @override
  Widget build(BuildContext context) {
    if(cupertinoIndicator){
      return Container(
        padding: EdgeInsets.all(30),
        child: CupertinoActivityIndicator(),
      );
    }
    return Container();
  }
}

