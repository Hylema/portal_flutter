import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:meta/meta.dart';

class BirthdayModel extends Birthday {
  BirthdayModel({
    @required birthdays,
  }) : super(
    birthdays: birthdays,
  );

  factory BirthdayModel.fromJson(json) {
    return BirthdayModel(
      birthdays: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birthdays': birthdays,
    };
  }
}