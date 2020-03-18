import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';

abstract class IVideoGalleryRepository {
  Future<Either<Failure, VideosGalleryModel>> getVideosFromNetwork(int pageIndex, int pageSize);
  //Future<Either<Failure, VideoGallery>> getVideosFromCache();
}