import 'package:meta/meta.dart';

class VideosGalleryModel {
  final id;
  final title;
  final videoUrl;
  final created;
  final String previewUrl;


  VideosGalleryModel({
    @required this.id,
    @required this.title,
    @required this.videoUrl,
    @required this.created,
    @required this.previewUrl,
  });

  static VideosGalleryModel fromJson(raw) {
    return VideosGalleryModel(
      id: raw['id'],
      title: raw['title'],
      videoUrl: raw['videoUrl'],
      created: raw['created'],
      previewUrl: raw['previewUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'videoUrl': videoUrl,
      'created': created,
      'previewUrl': previewUrl,
    };
  }

  bool fromYoutube() {
    if(previewUrl != null) {
      final youtube = RegExp('img.youtube.com').firstMatch(previewUrl)?.group(0);

      if(youtube != null) return true;
    }

    return false;
  }

  String getPreviewUrl() {
    if(fromYoutube()){
      String defaultUrl = RegExp('.*(\/|^)').firstMatch(previewUrl)?.group(0);
      return defaultUrl + 'mqdefault.jpg';
    } else return null;
  }
}