import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';

class PhoneBookCreateItem extends StatelessWidget {
  final PhoneBookModel phoneBookModel;

  PhoneBookCreateItem({@required this.phoneBookModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(phoneBookModel.name),
          trailing: phoneBookModel.code != '' ? Icon(Icons.chevron_right) : Container(),
          dense: true,
//          onTap: () => ,
        ),
        Container(
          color: Colors.grey[300],
          height: 1,
        )
      ],
    );
  }
}