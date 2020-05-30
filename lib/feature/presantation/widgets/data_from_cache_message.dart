import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataFromCacheMessageWidget extends StatelessWidget{

  final bool fromCache;
  DataFromCacheMessageWidget({@required this.fromCache});

  @override
  Widget build(BuildContext context) {
    if(!fromCache) return Container();
    else return Container(
      color: Colors.yellow.shade600,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          'Данные загружены из кэша',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}