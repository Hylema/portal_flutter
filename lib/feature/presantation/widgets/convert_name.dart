import 'package:flutter/cupertino.dart';

class ConvertName extends StatelessWidget {
  final String name;
  ConvertName({@required this.name});

  @override
  Widget build(BuildContext context) {
    String title;

    List<String> split = name.split(' ');
    split.asMap().forEach((int _index, String _string) {
      if(_index == 0) title = '$_string ';
      else title += _string.substring(0, 1).toUpperCase() + '.';
    });

    return Text(title);
  }
}