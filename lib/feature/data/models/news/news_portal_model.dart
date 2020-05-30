import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

class NewsModel {
  final getIt = GetIt.instance;

  final id;
  final title;
  final guid;
  final published;
  final cover;
  final body;
  final rubricId;
  final rubricTitle;
  int likesCount;
  List likedBy;
  int viewedCount;
  List viewedBy;

  NewsModel({
    @required this.id,
    @required this.title,
    @required this.guid,
    @required this.published,
    @required this.cover,
    @required this.body,
    @required this.rubricId,
    @required this.rubricTitle,
    @required this.likesCount,
    @required this.likedBy,
    @required this.viewedCount,
    @required this.viewedBy,
  });

  static NewsModel fromJson(raw) {
    return NewsModel(
      id: raw['id'],
      title: raw['title'],
      guid: raw['guid'],
      published: raw['published'],
      cover: raw['cover'],
      body: raw['body'],
      rubricId: raw['rubricId'],
      rubricTitle: raw['rubricTitle'],
      likesCount: raw['likesCount'],
      likedBy: raw['likedBy'],
      viewedCount: raw['viewedCount'],
      viewedBy: raw['viewedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'guid': guid,
      'published': published,
      'cover': cover,
      'body': body,
      'rubricId': rubricId,
      'rubricTitle': rubricTitle,
      'likesCount': likesCount,
      'likedBy': likedBy,
      'viewedCount': viewedCount,
      'viewedBy': viewedBy,
    };
  }

  bool isLike() {
    final Storage storage = getIt<Storage>();

    int userId = storage.currentUserModel.id;

    bool isLike = false;

    likedBy.forEach((likedId) {
      if(userId == likedId) {
        isLike = true;
        return;
      }
    });

    return isLike;
  }
}