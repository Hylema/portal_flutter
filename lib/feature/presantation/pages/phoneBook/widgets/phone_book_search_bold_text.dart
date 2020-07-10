import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneBookSearchBoldText extends StatelessWidget {
  final String text;
  final String searchString;
  PhoneBookSearchBoldText({@required this.text, @required this.searchString});

  @override
  Widget build(BuildContext context) {
    if(text == null || text == '') return Text('-');
    if(searchString == null || searchString == '') return Text(text);

    int start = RegExp((searchString).toLowerCase()).firstMatch((text).toLowerCase())?.start;
    int end = RegExp((searchString).toLowerCase()).firstMatch((text).toLowerCase())?.end;

    String firstPart = text.substring(0, start);
    String secondPart = text.substring(start, end);
    String thirdPart = text.substring(start + searchString.length, text.length);

    return Text.rich(
      TextSpan(
        text: firstPart,
        children: <TextSpan>[
          TextSpan(text: secondPart, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(text: thirdPart),
        ],
      ),
    );
  }
}