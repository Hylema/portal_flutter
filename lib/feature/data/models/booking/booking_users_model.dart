import 'package:meta/meta.dart';

class BookingUsersModel {
  final String key;
  final String name;
  final String email;
  final String position;
  final String department;

  BookingUsersModel({
    @required this.key,
    @required this.name,
    @required this.email,
    @required this.position,
    @required this.department,
  });

  static BookingUsersModel fromJson(raw){
    return BookingUsersModel(
      key: raw['key'],
      name: raw['name'],
      email: raw['email'],
      position: raw['position'],
      department: raw['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'email': email,
      'position': position,
      'department': department,
    };
  }
}

