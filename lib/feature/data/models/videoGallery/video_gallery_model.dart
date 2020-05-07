import 'package:meta/meta.dart';

class VideosGalleryModel {
  final id;
  final title;
  final videoUrl;
  final created;


  VideosGalleryModel({
    @required this.id,
    @required this.title,
    @required this.videoUrl,
    @required this.created,
  });

  static VideosGalleryModel fromJson(raw) {
    return VideosGalleryModel(
      id: raw['id'],
      title: raw['title'],
      videoUrl: raw['videoUrl'],
      created: raw['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'videoUrl': videoUrl,
      'created': created,
    };
  }
}