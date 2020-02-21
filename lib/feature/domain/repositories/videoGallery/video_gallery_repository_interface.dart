import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:flutter_architecture_project/feature/domain/entities/videoGallery/video_gallery.dart';

abstract class IVideoGalleryRepository {
  Future<Either<Failure, VideoGallery>> getVideosFromNetwork(int pageIndex, int pageSize);
  //Future<Either<Failure, VideoGallery>> getVideosFromCache();
}