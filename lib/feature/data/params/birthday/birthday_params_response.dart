import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';

class BirthdayResponse {
  final String title;
  final List<BirthdayModel> listModels;

  BirthdayResponse({@required this.title, @required this.listModels});

  Map<String, dynamic> toJson() {
    return {
      'listModels': listModels,
      'title': title,
    };
  }
}