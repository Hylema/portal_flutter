import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/feature/domain/entities/videoGallery/video_gallery.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/videoGallery/video_gallery_repository_interface.dart';

class GetVideoGalleryFromNetwork implements UseCase<VideoGallery, VideoGalleryParams>{
  final IVideoGalleryRepository repository;

  GetVideoGalleryFromNetwork(this.repository);

  @override
  Future<Either<Failure, VideoGallery>> call(VideoGalleryParams params) async {
    return await repository.getVideosFromNetwork(params.pageIndex, params.pageSize);
  }
}

class VideoGalleryParams extends Equatable {
  final int pageIndex;
  final int pageSize;

  VideoGalleryParams({
    @required this.pageIndex,
    @required this.pageSize,
  }) : super([pageIndex, pageSize]);
}