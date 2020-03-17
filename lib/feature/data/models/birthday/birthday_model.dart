import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:meta/meta.dart';

class BirthdayModel {
  final String fatherName;
  final String lastName;
  final String firstName;
  final String positionName;
  final int birthdayMonth;
  final int birthdayDay;
  final String photoUrl;

  BirthdayModel({
    @required this.fatherName,
    @required this.lastName,
    @required this.firstName,
    @required this.positionName,
    @required this.birthdayMonth,
    @required this.birthdayDay,
    @required this.photoUrl,
  });

  static BirthdayModel fromJson(raw){
    return BirthdayModel(
      fatherName: raw['fatherName'],
      lastName: raw['lastName'],
      firstName: raw['firstName'],
      positionName: raw['positionName'],
      birthdayMonth: raw['birthdayMonth'].toInt(),
      birthdayDay: raw['birthdayDay'].toInt(),
      photoUrl: raw['photoUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fatherName': fatherName,
      'lastName': lastName,
      'firstName': firstName,
      'positionName': positionName,
      'birthdayMonth': birthdayMonth,
      'birthdayDay': birthdayDay,
      'photoUrl': photoUrl
    };
  }
}