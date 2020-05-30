import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/videoGallery/video_gallery_params.dart';

abstract class IVideoGalleryRepository {
  Future<List<VideosGalleryModel>> fetchVideos({VideoGalleryParams params});
  Future<List<VideosGalleryModel>> updateVideos({VideoGalleryParams params});
}