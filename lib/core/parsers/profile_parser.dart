import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'dart:convert';

class Parser {
  Map profile({@required data}) {
    Map profileData = {
      'name': null,
      'email': null,
      'position': null,
      'pictureUrl': null,
      'workPhone': null,
      'department': null,
      'startWork': null,
      'birthday': null,
    };

    ///Внутренний телефон = WorkPhone
    ///Департамент = Department
    ///Начало работы = SPS-PersonalSiteFirstCreationTime
    ///День рождения = SPS-Birthday

    profileData['name'] = data['DisplayName'];
    profileData['email'] = data['Email'];
    profileData['position'] = data['Title'];
    profileData['pictureUrl'] = data['PictureUrl'];

    final userProfile = data['UserProfileProperties'];
    for (var element in userProfile) {
      switch(element['Key']){
        case 'WorkPhone': profileData['workPhone'] = element['Value']; break;
        case 'Department': profileData['department'] = element['Value']; break;
        case 'SPS-PersonalSiteFirstCreationTime': profileData['startWork'] = element['Value']; break;
        case 'SPS-Birthday': profileData['birthday'] = element['Value']; break;
      }
    }

    return profileData;
  }
}