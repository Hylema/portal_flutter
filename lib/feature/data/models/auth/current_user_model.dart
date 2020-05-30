import 'package:meta/meta.dart';

class CurrentUserModel {
  final id;
  final key;
  final name;
  final email;

  CurrentUserModel({
    @required this.id,
    @required this.key,
    @required this.name,
    @required this.email,
  });

  static CurrentUserModel fromJson(raw){
    var value = raw[0];

    return CurrentUserModel(
      id: value['id'],
      key: value['key'],
      name: value['name'],
      email: value['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'email': email,
    };
  }
}