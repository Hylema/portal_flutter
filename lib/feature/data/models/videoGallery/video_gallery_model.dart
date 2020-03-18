import 'package:meta/meta.dart';

class VideosGalleryModel {
  final videos;
  VideosGalleryModel({
    @required this.videos,
  });

  factory VideosGalleryModel.fromJson(json) {
    return VideosGalleryModel(
      videos: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': videos,
    };
  }
}