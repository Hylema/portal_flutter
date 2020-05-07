import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoGalleryState extends Equatable{
  @override
  List<Object> get props => [];
}

class EmptyVideoGalleryState extends VideoGalleryState {}
class LoadingVideoGalleryState extends VideoGalleryState {}

class LoadedVideoGalleryState extends VideoGalleryState {
  final List<VideosGalleryModel> listModels;
  final bool hasReachedMax;

  LoadedVideoGalleryState({@required this.listModels, this.hasReachedMax});

  LoadedVideoGalleryState copyWith({
    List<VideosGalleryModel> birthdays,
    bool hasReachedMax,
  }) {
    return LoadedVideoGalleryState(
      listModels: listModels ?? this.listModels,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [listModels, hasReachedMax];
}
class ErrorVideoGalleryState extends VideoGalleryState {
  final String message;

  ErrorVideoGalleryState({@required this.message});
}

class VideoGalleryFromCacheState extends VideoGalleryState {
  final List<VideosGalleryModel> listModels;

  VideoGalleryFromCacheState({@required this.listModels});
}


