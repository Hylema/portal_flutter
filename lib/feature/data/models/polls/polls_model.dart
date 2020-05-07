import 'package:meta/meta.dart';

class PollsModel {
  final id;
  final type;
  final created;
  final likedBy;
  final likesCount;
  final title;
  final link;
  final newDate;
  final endDate;

  PollsModel({
    @required this.id,
    @required this.type,
    @required this.created,
    @required this.likedBy,
    @required this.likesCount,
    @required this.title,
    @required this.link,
    @required this.newDate,
    @required this.endDate,
  });

  static PollsModel fromJson(raw){
    return PollsModel(
      id: raw['id'],
      type: raw['type'],
      created: raw['created'],
      likedBy: raw['likedBy'],
      likesCount: raw['likesCount'],
      title: raw['title'],
      link: raw['link'],
      newDate: raw['newDate'],
      endDate: raw['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'created': created,
      'likedBy': likedBy,
      'likesCount': likesCount,
      'title': title,
      'link': link,
      'newDate': newDate,
      'endDate': endDate,
    };
  }
}