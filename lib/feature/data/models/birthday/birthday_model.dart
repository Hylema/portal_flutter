import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:meta/meta.dart';

class BirthdayModel {
  List birthdays;
  bool noDataMore;

  BirthdayModel({
    @required this.birthdays,
    this.noDataMore,
  });

  static BirthdayModel fromJson({@required Map json}){
    return BirthdayModel(birthdays: json['data']);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': birthdays,
    };
  }
}