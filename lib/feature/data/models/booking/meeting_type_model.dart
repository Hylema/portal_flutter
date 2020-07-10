import 'package:meta/meta.dart';

class MeetingTypeModel {
  final int id;
  final String title;
  final String color;

  MeetingTypeModel({
    @required this.id,
    @required this.title,
    @required this.color,
  });

  static MeetingTypeModel fromJson(raw){
    return MeetingTypeModel(
      id: raw['id'],
      title: raw['title'],
      color: raw['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
    };
  }
}

