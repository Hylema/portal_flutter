import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';

class Model<Type> {
  dynamic model;

  Model({@required this.model});

  fromJson(json) {
    if(model == BirthdayModel)
      return BirthdayModel(
          birthdays: json['data']
      );
  }

  Map toJson() {
    return {
      'data': model.birthdays,
    };
    if(model == BirthdayModel){
      return {
        'birthdays': model.birthday,
      };
    }
  }
}