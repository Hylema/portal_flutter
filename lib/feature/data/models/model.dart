import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';

class Model<Type> {
  var model;

  Model({@required this.model});

  Type fromJson(json) {
    if(model is BirthdayModel){
      model.birthdays = json['data'];
      return model;
    }
  }
}