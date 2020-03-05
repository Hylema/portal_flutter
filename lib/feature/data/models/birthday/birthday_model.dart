import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:meta/meta.dart';

class BirthdayModel extends Birthday {
  List birthdays;

  BirthdayModel({
    @required this.birthdays,
  }) : super(
    birthdays: birthdays,
  );

  Map<String, dynamic> toJson() {
    return {
      'birthdays': birthdays,
    };
  }
}