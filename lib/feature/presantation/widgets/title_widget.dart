import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget{
  TitleWidget({
    this.title,
    this.titleSize = 22,
    this.maxSymbol = 100,
    this.lineHeight = 1.2,
    this.letterSpacing = 0.2,
    this.color = Colors.white
  }){
    assert(title != null);
  }
  String title;
  final Color color;
  final double titleSize;
  final double lineHeight;
  final double letterSpacing;
  final int maxSymbol;

  @override
  Widget build(BuildContext context) {

    String resultTitle;

    title = title.replaceAll(new RegExp(r"\s+\b|\b\s"), "");

    if(title.length > maxSymbol){
      resultTitle = title.substring(0, maxSymbol) + '...';
    } else {
      resultTitle = title;
    }

    return Text(
      resultTitle,
      style: TextStyle(
          fontSize: titleSize,
          fontWeight: FontWeight.bold,
          height: lineHeight,
          color: color,
          letterSpacing: letterSpacing
      ),
    );
  }
}
