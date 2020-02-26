import 'package:flutter_architecture_project/feature/domain/entities/videoGallery/video_gallery.dart';
import 'package:meta/meta.dart';

class VideosGalleryModel extends VideoGallery {
  VideosGalleryModel({
    @required videos,
  }) : super(
    videos: videos,
  );

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