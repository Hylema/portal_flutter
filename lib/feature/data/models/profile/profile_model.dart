import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:meta/meta.dart';

class ProfileModel {
  final name;
  final email;
  final position;
  final pictureUrl;
  final workPhone;
  final department;
  final startWork;
  final birthday;

  ProfileModel({
    @required this.name,
    @required this.email,
    @required this.position,
    @required this.pictureUrl,
    @required this.workPhone,
    @required this.department,
    @required this.startWork,
    @required this.birthday,
  });

  static ProfileModel parsData(raw) {
    final Parser _parser = new Parser();
    final Map _profileData = _parser.profile(data: raw);

    return ProfileModel(
      name: _profileData['name'],
      email: _profileData['email'],
      position: _profileData['position'],
      pictureUrl: _profileData['pictureUrl'],
      workPhone: _profileData['workPhone'],
      department: _profileData['department'],
      startWork: _profileData['startWork'],
      birthday: _profileData['birthday'],
    );
  }

  static ProfileModel fromJson(raw) {

    return ProfileModel(
      name: raw['name'],
      email: raw['email'],
      position: raw['position'],
      pictureUrl: raw['pictureUrl'],
      workPhone: raw['workPhone'],
      department: raw['department'],
      startWork: raw['startWork'],
      birthday: raw['birthday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'position': position,
      'pictureUrl': pictureUrl,
      'workPhone': workPhone,
      'department': department,
      'startWork': startWork,
      'birthday': birthday,
    };
  }
}